//
//  WeatherManager.swift
//  Weather
//
//  Created by 이상수 on 6/2/25.
//

import SwiftUI
import CoreLocation

class WeatherManager: ObservableObject {

    @Published var items: [WeatherItem] = []
    @Published var summaries: Array<(String, WeatherSummary)> = []

    func fetchWeather(location: CLLocationCoordinate2D) async {
        do {
            let items = try await WeatherAPI.fetchWeather(from: location)
            await MainActor.run {
                self.items = items
                self.summaries = self.parseAllWeather(from: items)
            }
        } catch {
            print("WeatherManager error: \(error)")
        }
    }

    private func parseAllWeather(from items: [WeatherItem]) -> Array<(String, WeatherSummary)> {
        let grouped = Dictionary(grouping: items) {
            "\($0.fcstDate) \($0.fcstTime)"
        }

        var result: [String: WeatherSummary] = [:]

        for (datetime, values) in grouped {
            var dict: [String: String] = [:]
            for item in values {
                dict[item.category] = item.fcstValue
            }

            guard let tmp = dict["TMP"],
                  let wsd = dict["WSD"],
                  let sky = dict["SKY"],
                  let pty = dict["PTY"],
                  let pcp = dict["PCP"],
                  let pop = dict["POP"] else { continue }

            result[datetime] = WeatherSummary(
                temperature: tmp,
                windSpeed: wsd,
                sky: sky,
                rainType: pty,
                rainAmount: pcp,
                rainProb: pop
            )
        }
        
        let parsedData = result.sorted { l, r in
            l.key < r.key
        }.map { ($0.key, $0.value) }

        print(parsedData)
        return parsedData
    }

}
