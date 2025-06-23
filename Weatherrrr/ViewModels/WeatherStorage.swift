//
//  WeatherStorage.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/17/25.
//

import SwiftUI
import CoreLocation

class WeatherStorage: ObservableObject {

    @Published private(set) var stored: [WeatherReport] = [] {
        didSet {
            saveToDisk()
        }
    }

    init() {
        loadFromDisk()
    }

    @MainActor
    func store(coordinate: CLLocationCoordinate2D?) {
        Task {
            do {
                let weather = try await WeatherLoader.load(coordinate: coordinate)
                stored.append(weather)
            } catch {
                print("weatherstorage error: \(error)")
            }
        }
    }

    private func saveToDisk() {
        do {
            let data = try JSONEncoder().encode(stored)
            try data.write(to: fileURL())
        } catch {
            print("저장 실패: \(error)")
        }
    }

    private func loadFromDisk() {
        guard FileManager.default.fileExists(atPath: fileURL().path) else {
            return
        }

        do {
            let data = try Data(contentsOf: fileURL())
            let reports = try JSONDecoder().decode([WeatherReport].self, from: data)
            stored = reports
        } catch {
            print("불러오기 실패: \(error)")
        }
    }

}

extension WeatherStorage {

    private func fileURL() -> URL {
        let doc = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return doc.appendingPathComponent("weather_reports.json")
    }

}
