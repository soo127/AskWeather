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

    var currentData: WeatherData {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd HH00"
        let date = formatter.string(from: Date())
        //print(parsedItems.first(where: { $0["DATE"] == date }) ?? [:])
        return parsedItems.first(where: { $0["DATE"] == date }) ?? [:]
    }

    var rotateAngle: Double {
        guard let vecString = currentData["VEC"],
              let vec = Double(vecString) else {
            return 0.0
        }
        return vec - 90.0
    }

    var radian: Double {
        return Angle(degrees: rotateAngle).radians
    }

    var windSpeed: Double {
        guard let speedString = currentData["WSD"],
              let speed = Double(speedString) else {
            return 0.0
        }
        return speed
    }

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

    private func parseAllWeather(from items: [RawWeatherItem]) -> [WeatherData] {
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
        print(result)
        return result
    }

}
