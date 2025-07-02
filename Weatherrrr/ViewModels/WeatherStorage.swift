//
//  WeatherStorage.swift
//  Weatherrrr
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
    var now: Date {
        Date()
    }

    init() {
        loadFromDisk()
    }

    @MainActor
    func addFavorite(coordinate: CLLocationCoordinate2D?, address: String?) {
        Task {
            do {
                let report = try await WeatherLoader.load(coordinate: coordinate, displayAddress: address)
                favorites.append(report)
            } catch {
                print("weatherstorage error: \(error)")
            }
        }
    }

    func hasFavorite(coordinate: CLLocationCoordinate2D?) -> Bool {
        guard let target = coordinate else { return false }

        return favorites.contains { report in
            let c = report.coordinate
            let delta = 0.0001

            return abs(c.latitude - target.latitude) < delta &&
            abs(c.longitude - target.longitude) < delta
        }
    }

    func handleRemove() {
        isEditMode.toggle()
        if !isEditMode {
            removeFavorites(ids: checkedFavorites)
            checkedFavorites.removeAll()
        }
    }

    func toggleFavorite(report: WeatherReport) {
        if checkedFavorites.contains(report.id) {
            checkedFavorites.remove(report.id)
        } else {
            checkedFavorites.insert(report.id)
        }
    }

    private func removeFavorites(ids: Set<UUID>) {
        favorites.removeAll { ids.contains($0.id) }
    }

}

//MARK: - Update 관련

extension WeatherStorage {
 
    func scheduleUpdate(coordinate: CLLocationCoordinate2D?) {
        Task {
            await update(coordinate: coordinate)
        }
        guard let delay = delay() else {
            return
        }
        Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { [weak self] _ in
            guard let self else { return }
            Task {
                print(delay)
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
            currentWeather = try await WeatherLoader.load(coordinate: coordinate)
        } catch {
            print("weatherstorage error2: \(error)")
        }
    }

    @MainActor
    private func updateFavorites() async {
        var updated: [WeatherReport] = []
        for favorite in favorites {
            do {
                let lat = favorite.latitude
                let lon = favorite.longitude
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                
                let newReport = try await WeatherLoader.load(coordinate: coordinate, displayAddress: favorite.address)
                updated.append(newReport)
            } catch {
                print("weatherStorage error3: \(error)")
            }
        }
        favorites = updated
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


