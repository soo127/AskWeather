//
//  WeatherStorage.swift
//  AskWeather
//
//  Created by 이상수 on 6/17/25.
//

import SwiftUI
import CoreLocation
import WidgetKit

class WeatherStorage: ObservableObject {

    @Published private(set) var currentWeather: WeatherReport = .empty
    @Published var favorites: [WeatherReport] = [] {
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
        favorites.append(report)
    }

    func hasFavorite(report: WeatherReport) -> Bool {
        return favorites.contains(where: { $0.address == report.address })
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
    
    func isSelected(report: WeatherReport) -> Bool {
        checkedFavorites.contains(report.id)
    }

    private func removeFavorites(ids: Set<UUID>) {
        favorites.removeAll { ids.contains($0.id) }
    }

}

//MARK: - Update 관련

extension WeatherStorage {
 
    // 실행 즉시 업데이트 후 시간 단위 업데이트 (4:35 실행 -> 5:00 -> 6:00 -> ...)
    func scheduleUpdate(coordinate: CLLocationCoordinate2D?) {
        guard let coordinate, let delay = delay() else {
            return
        }
        Task { @MainActor in
            await update(coordinate: coordinate)
            isReady = true
        }
        Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { [weak self] _ in
            guard let self else { return }
            Task {
                await self.update(coordinate: coordinate)
            }
            scheduleHourlyUpdate(coordinate: coordinate)
        }
    }
    
    private func delay() -> TimeInterval? {
        return now.nextHour()?.timeIntervalSince(now)
    }
    
    private func scheduleHourlyUpdate(coordinate: CLLocationCoordinate2D?) {
        Timer.scheduledTimer(withTimeInterval: 3600, repeats: true) { [weak self] _ in
            guard let self else { return }
            Task {
                await self.update(coordinate: coordinate)
            }
        }
    }
    
    @MainActor
    private func update(coordinate: CLLocationCoordinate2D?) async {
        async let current: () = updateCurrentWeather(coordinate: coordinate)
        async let refresh: () = updateFavorites()
        _ = await (current, refresh)
        updateWidget()
    }

    @MainActor
    private func updateCurrentWeather(coordinate: CLLocationCoordinate2D?) async {
        do {
            currentWeather = try await WeatherLoader.loadWithRetry(coordinate: coordinate)
        } catch {
            print("updateCurrentWeather error: \(error)")
        }
    }

    @MainActor
    private func updateFavorites() async {
        await withTaskGroup(of: (Int, WeatherReport).self) { group in
            for (index, favorite) in favorites.enumerated() {
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
                        return (index, report)
                    } catch {
                        print("updateFavorites error: \(error)")
                        return (index, favorite)
                    }
                }
            }
            
            var results: [(Int, WeatherReport)] = []
            for await result in group {
                results.append(result)
            }
            
            results.sort { $0.0 < $1.0 }
            favorites = results.map { $0.1 }
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

    private func loadFromDisk() {
        guard FileManager.default.fileExists(atPath: fileURL().path) else {
            return
        }
        do {
            let data = try Data(contentsOf: fileURL())
            let reports = try JSONDecoder().decode([WeatherReport].self, from: data)
            favorites = reports
        } catch {
            print("불러오기 실패: \(error)")
        }
    }

    private func storeToDisk() {
        do {
            let data = try JSONEncoder().encode(favorites)
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
