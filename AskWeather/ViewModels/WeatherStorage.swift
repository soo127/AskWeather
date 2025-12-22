//
//  WeatherStorage.swift
//  AskWeather
//
//  Created by 이상수 on 6/17/25.
//

import SwiftUI
import CoreLocation
import WidgetKit
import OrderedCollections

@MainActor
class WeatherStorage: ObservableObject {

    @Published private(set) var currentWeather: WeatherReport = .empty
    @Published private(set) var favorites: OrderedDictionary<WeatherReport.ID, WeatherReport> = [:] {
        didSet {
            storeToDisk()
        }
    }
    
    @Published var isEditMode = false
    @Published var checkedFavorites: Set<UUID> = []
    @Published var isReady = false
    var now: Date {
        Date()
    }

    init() {
        loadFromDisk()
    }

    func addFavorite(report: WeatherReport) {
        favorites[report.id] = report
    }

    func hasFavorite(id: WeatherReport.ID) -> Bool {
        favorites[id] != nil
    }

    func handleRemove() {
        if isEditMode {
            removeFavorites(ids: checkedFavorites)
            checkedFavorites.removeAll()
        }
        isEditMode.toggle()
    }

    func toggleFavorite(report: WeatherReport) {
        if isSelected(report: report) {
            checkedFavorites.remove(report.id)
        } else {
            checkedFavorites.insert(report.id)
        }
    }

    func moveFavorites(fromOffsets: IndexSet, toOffset: Int) {
        /// id값은 고정, value만 offset에 따라 움직이는 이슈
        favorites.values.move(fromOffsets: fromOffsets, toOffset: toOffset)
        /// 다시 순회하면서 id를 세팅함
        let newFavorites: OrderedDictionary<WeatherReport.ID, WeatherReport> = OrderedDictionary(
            uniqueKeysWithValues: favorites.values.map { ($0.id, $0) }
        )
        favorites = newFavorites
    }

    func isSelected(report: WeatherReport) -> Bool {
        checkedFavorites.contains(report.id)
    }

    private func removeFavorites(ids: Set<UUID>) {
        ids.forEach {  favorites[$0] = nil }
    }

}

//MARK: - Update 관련

extension WeatherStorage {
 
    // 실행 즉시 업데이트 후 시간 단위 업데이트 (4:35 실행 -> 5:00 -> 6:00 -> ...)
    func scheduleUpdate(coordinate: CLLocationCoordinate2D?) async throws {
        guard let coordinate, let delay = delay() else {
            return
        }
        await update(coordinate: coordinate)
        isReady = true

        try await Task.sleep(nanoseconds: delay * 1_000_000_000)
        await self.update(coordinate: coordinate)
        self.scheduleHourlyUpdate(coordinate: coordinate)
    }
    
    private func delay() -> UInt64? {
        guard let interval = now.nextHour()?.timeIntervalSince(now) else {
            return nil
        }
        return UInt64(interval)
    }
    
    private func scheduleHourlyUpdate(coordinate: CLLocationCoordinate2D?) {
        Timer.scheduledTimer(withTimeInterval: 3600, repeats: true) { [weak self] _ in
            guard let self else { return }
            Task {
                await self.update(coordinate: coordinate)
            }
        }
    }
    
    private func update(coordinate: CLLocationCoordinate2D?) async {
        async let current: () = updateCurrentWeather(coordinate: coordinate)
        async let refresh: () = updateFavorites()
        _ = await (current, refresh)
        updateWidget()
    }

    private func updateCurrentWeather(coordinate: CLLocationCoordinate2D?) async {
        do {
            currentWeather = try await WeatherLoader.loadWithRetry(coordinate: coordinate)
        } catch {
            print("updateCurrentWeather error: \(error)")
        }
    }

    private func updateFavorites() async {
        let keys = Array(favorites.keys)
        
        await withTaskGroup(of: (WeatherReport.ID, WeatherReport).self) { group in
            for key in keys {
                guard let favorite = favorites[key] else { continue }
                
                group.addTask {
                    do {
                        let coordinate = CLLocationCoordinate2D(
                            latitude: favorite.latitude,
                            longitude: favorite.longitude
                        )
                        let report = try await WeatherLoader.loadWithRetry(
                            coordinate: coordinate,
                            displayAddress: favorite.address
                        )
                        return (key, report)
                    } catch {
                        print("updateFavorites error: \(error)")
                        return (key, favorite)
                    }
                }
            }
            
            var updates: [WeatherReport.ID: WeatherReport] = [:]
            for await (id, report) in group {
                updates[id] = report
            }
            
            var updated: OrderedDictionary<WeatherReport.ID, WeatherReport> = [:]
            for key in keys {
                updated[key] =  updates[key]
            }
            
            favorites = updated
        }
    }
    
    ///위젯 전용
    private func updateWidget() {
        do {
            let widgetData = try currentWeather.toWidgetModel()
            let data = try JSONEncoder().encode(widgetData)
            try data.write(to: SharedFile.widgetWeatherURL)
            WidgetCenter.shared.reloadTimelines(ofKind: "AskWeatherWidget")
        } catch {
            print("위젯용 저장 실패: \(error)")
        }
    }
    
}

//MARK: - load/store

extension WeatherStorage {
    
    private typealias CodableReports = [WeatherReport]
    
    private func loadFromDisk() {
        guard FileManager.default.fileExists(atPath: fileURL().path) else {
            return
        }
        do {
            let data = try Data(contentsOf: fileURL())
            let reports = try JSONDecoder().decode(CodableReports.self, from: data)
            let dict: OrderedDictionary<WeatherReport.ID, WeatherReport> = OrderedDictionary(
                uniqueKeysWithValues: reports.map { ($0.id, $0) }
            )
            favorites = dict
        } catch {
            print("불러오기 실패: \(error)")
        }
    }

    private func storeToDisk() {
        do {
            let reports: CodableReports = Array(favorites.values)
            let data = try JSONEncoder().encode(reports)
            try data.write(to: fileURL())
        } catch {
            print("저장 실패: \(error)")
        }
    }

}

//MARK: - 기타

extension WeatherStorage {

    private func fileURL() -> URL {
        let doc = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return doc.appendingPathComponent("weather_reports.json")
    }

}
