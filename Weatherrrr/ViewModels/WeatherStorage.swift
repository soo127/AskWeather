//
//  WeatherStorage.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/17/25.
//

import SwiftUI
import CoreLocation

class WeatherStorage: ObservableObject {

    @Published private(set) var currentWeather: WeatherReport = .empty
    @Published private(set) var favorites: [WeatherReport] = [] {
        didSet {
            storeToDisk()
        }
    }
    @Published var isEditMode = false
    @Published var checkedFavorites: Set<UUID> = []

    init() {
        loadFromDisk()
    }

    @MainActor
    func addFavorite(coordinate: CLLocationCoordinate2D?) {
        Task {
            do {
                let report = try await WeatherLoader.load(coordinate: coordinate)
                favorites.append(report)
            } catch {
                print("weatherstorage error: \(error)")
            }
        }
    }

    func handleRemove() {
        isEditMode.toggle()
        if !isEditMode {
            removeFavorites(ids: checkedFavorites)
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

//MARK: - 초기 설정

extension WeatherStorage {

    @MainActor
    func update(coordinate: CLLocationCoordinate2D?) async {
        async let current: () = updateCurrentWeather(coordinate: coordinate)
        async let refresh: () = updateFavorites(favorites)
        _ = await (current, refresh)
    }

    @MainActor
    func updateCurrentWeather(coordinate: CLLocationCoordinate2D?) async {
        do {
            currentWeather = try await WeatherLoader.load(coordinate: coordinate)
        } catch {
            print("weatherstorage error: \(error)")
        }
    }

    @MainActor
    private func updateFavorites(_ reports: [WeatherReport]) async {
        var updated: [WeatherReport] = []
        let now = Date()

        for report in reports {
            guard !report.updatedAt.isSameHour(comparedTo: now) else { // can use cache
                updated.append(report)
                continue
            }
            do {
                let coordinate = CLLocationCoordinate2D(latitude: report.latitude, longitude: report.longitude)
                let newReport = try await WeatherLoader.load(coordinate: coordinate)
                updated.append(newReport)
            } catch {
                print("weatherStorage error: \(error)")
            }
        }
        favorites = updated
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
