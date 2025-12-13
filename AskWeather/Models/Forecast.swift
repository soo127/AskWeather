//
//  Forecast.swift
//  AskWeather
//
//  Created by 이상수 on 6/9/25.
//

import SwiftUI

struct Forecast: Codable {

    let date: Date
    var temperature: Int = .zero
    var humidity: Int = .zero
    var windSpeed: Double = .zero
    var windVector: Int = .zero
    var cloud: CloudCondition = .clear
    var precipitationType: PrecipitationType = .none
    var parcipitation: Double = .zero
    var dailyHighTemp: Double = .zero
    var dailyLowTemp: Double = .zero

    enum CloudCondition: String, Codable {
        case clear = "1"
        case cloudy = "3"
        case overcast = "4"
        case unknown

        init(from rawValue: String) {
            self = CloudCondition(rawValue: rawValue) ?? .unknown
        }
    }

    enum PrecipitationType: String, Codable {
        case none = "0"
        case rain = "1"
        case sleet = "2"
        case snow = "3"
        case shower = "4"
        case unknown
        
        init(from rawValue: String) {
            self = PrecipitationType(rawValue: rawValue) ?? .unknown
        }
    }

}

extension Forecast {

    mutating func update(items: [KMAAPI.Item]) {
        items
            .forEach { self.update(item: $0) }
    }

    mutating private func update(item: KMAAPI.Item) {
        switch item.category {
        case .temperature:
            self.temperature = Int(item.fcstValue) ?? temperature
        case .humidity:
            self.humidity = Int(item.fcstValue) ?? humidity
        case .windSpeed:
            self.windSpeed = Double(item.fcstValue) ?? windSpeed
        case .windVector:
            self.windVector = Int(item.fcstValue) ?? windVector
        case .cloud:
            self.cloud = CloudCondition(from: item.fcstValue)
        case .precipitationType:
            self.precipitationType = PrecipitationType(from: item.fcstValue)
        case .parcipitation:
            self.parcipitation = parsePrecipitation(item.fcstValue)
        case .dailyHighTemp:
            self.dailyHighTemp = Double(item.fcstValue) ?? dailyHighTemp
        case .dailyLowTemp:
            self.dailyLowTemp = Double(item.fcstValue) ?? dailyLowTemp
        case .unknown:
            break
        }
    }

}

extension Forecast {

    private func parsePrecipitation(_ precipitation: String) -> Double {
        switch precipitation {
        case "강수없음":
            return 0
        case "1mm 미만":
            return 0.05
        case "30":
            return 40.0
        case "50":
            return 60.0
        default:
            return Double(precipitation.replacingOccurrences(of: "mm", with: "")) ?? 0
        }
    }

}
