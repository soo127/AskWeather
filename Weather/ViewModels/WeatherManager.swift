//
//  WeatherManager.swift
//  Weather
//
//  Created by 이상수 on 6/2/25.
//

import SwiftUI
import CoreLocation

typealias WeatherData = [String: String]

class WeatherManager: ObservableObject {

    @Published var parsedItems : [WeatherData] = []

    func fetchWeather(location: CLLocationCoordinate2D) async {
        do {
            let items = try await WeatherAPI.fetchWeather(from: location)
            await MainActor.run {
                self.parsedItems = self.parseAllWeather(from: items)
            }
        } catch {
            print("WeatherManager error: \(error)")
        }
    }

    private func parseAllWeather(from items: [WeatherItem]) -> [WeatherData] {
        let grouped = Dictionary(grouping: items) {
            "\($0.fcstDate) \($0.fcstTime)"
        }

        var result: [WeatherData] = []
        for datetime in grouped.keys.sorted() {
            guard let values = grouped[datetime] else { continue }
            var dict: WeatherData = [:]
            dict["DATE"] = datetime
            for item in values {
                dict[item.category] = item.fcstValue
            }
            result.append(dict)
        }
        return result
    }

}
