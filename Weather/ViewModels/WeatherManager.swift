//
//  WeatherManager.swift
//  Weather
//
//  Created by 이상수 on 6/2/25.
//

import SwiftUI
import CoreLocation

typealias ParsedWeatherData = [String: String]

class WeatherManager: ObservableObject {

    @Published var parsedItems: [ParsedWeatherData] = []

    private func formattedDate(later: Int = 0, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let targetDate = Calendar.current.date(byAdding: .day, value: later, to: Date())!
        return formatter.string(from: targetDate)
    }

    var currentData: ParsedWeatherData {
        let date = formattedDate(format: "yyyyMMdd HH00")
        return parsedItems.first(where: { $0["DATE"] == date }) ?? [:]
    }

    // MARK: - Weather Fetching

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

    private func parseAllWeather(from items: [WeatherItem]) -> [ParsedWeatherData] {
        let grouped = Dictionary(grouping: items) {
            "\($0.fcstDate) \($0.fcstTime)"
        }

        var result: [ParsedWeatherData] = []
        for datetime in grouped.keys.sorted() {
            guard let values = grouped[datetime] else { continue }
            var dict: ParsedWeatherData = [:]
            dict["DATE"] = datetime
            for item in values {
                dict[item.category] = item.fcstValue
            }
            result.append(dict)
        }
        return result
    }

    // MARK: - Computed Properties

    var humidity: Double {
        guard let humidityString = currentData["REH"],
              let humidity = Double(humidityString) else {
            return -1
        }
        return humidity
    }

    var temperature: Double {
        guard let temperatureString = currentData["TMP"],
              let temperature = Double(temperatureString) else {
            return -1
        }
        return temperature
    }

    var averagePrecipitation: Double {
        let date = formattedDate(format: "yyyyMMdd")
        let values = parsedItems
            .filter {
                guard let fullDate = $0["DATE"], fullDate.contains(date) else {
                    return false
                }
                return true
            }
            .compactMap { $0["PCP"] }

        let totalPrecipitation = values.reduce(0.0) { sum, pcpString in
            switch pcpString {
            case "강수없음":
                return sum + 0
            case "1mm 미만":
                return sum + 0.05
            case "30":
                return sum + 40.0 // 30.0~50.0mm의 중간값
            case "50":
                return sum + 60.0 // 50.0mm 이상을 대표하는 값
            default:
                return sum + (Double(pcpString) ?? 0)
            }
        }

        return totalPrecipitation / Double(values.count)
    }

    var rotateAngle: Double {
        guard let vecString = currentData["VEC"],
              let vec = Double(vecString) else {
            return 0.0
        }
        return vec + 90.0
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

    // MARK: - Daily Info Accessors

    func getDailySky(_ later: Int) -> String {
        let date = formattedDate(later: later, format: "yyyyMMdd")
        let skyValues = parsedItems
            .filter {
                guard let fullDate = $0["DATE"], fullDate.contains(date) else {
                    return false
                }
                return (fullDate.suffix(4) >= "0600") && (fullDate.suffix(4) <= "2100")
            }
            .compactMap { $0["SKY"] }

        return determineSky(from: skyValues)
    }

    private func determineSky(from skyValues: [String]) -> String {
        let clear = skyValues.filter { $0 == "1" }.count
        let cloudy = skyValues.filter { $0 == "3" }.count
        let overcast = skyValues.filter { $0 == "4" }.count

        let sum = clear + cloudy + overcast
        if cloudy + overcast >= sum / 3 {
            return overcast != 0 ? "cloud" : "cloud.sun"
        }
        return "sun.max"
    }

    func getLowestTemp(later: Int) -> Double {
        let date = formattedDate(later: later, format: "yyyyMMdd 0600")

        guard let item = parsedItems.first(where: { $0["DATE"] == date }),
              let l = item["TMN"], let low = Double(l) else {
            return 0
        }
        return low
    }

    func getHighestTemp(later: Int) -> Double {
        let date = formattedDate(later: later, format: "yyyyMMdd 1500")

        guard let item = parsedItems.first(where: { $0["DATE"] == date }),
              let h = item["TMX"], let high = Double(h) else {
            return 0
        }
        return high
    }

}

