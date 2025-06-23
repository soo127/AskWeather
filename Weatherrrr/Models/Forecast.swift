//
//  Forecast.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/9/25.
//

import SwiftUI

struct Forecast: Codable {

    let date: Date
    var temperature: Int = .zero
    var dailyHighTemp: Double = .zero
    var dailyLowTemp: Double = .zero
    var parcipitation: Double = .zero
    var humidity: Int = .zero
    var windVector: Int = .zero
    var windSpeed: Double = .zero
    var skyCondition: SkyCondition = .clear

    enum SkyCondition: String, Codable {
        case clear = "1"
        case cloudy = "3"
        case overcast = "4"
        case unknown

        init(from rawValue: String) {
            self = SkyCondition(rawValue: rawValue) ?? .unknown
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
        case .parcipitation:
            self.parcipitation = parsePrecipitation(item.fcstValue)
        case .humidity:
            self.humidity = Int(item.fcstValue) ?? humidity
        case .dailyHighTemp:
            self.dailyHighTemp = Double(item.fcstValue) ?? dailyHighTemp
        case .dailyLowTemp:
            self.dailyLowTemp = Double(item.fcstValue) ?? dailyLowTemp
        case .temperature:
            self.temperature = Int(item.fcstValue) ?? temperature
        case .windVector:
            self.windVector = Int(item.fcstValue) ?? windVector
        case .windSpeed:
            self.windSpeed = Double(item.fcstValue) ?? windSpeed
        case .skyCondition:
            self.skyCondition = SkyCondition(from: item.fcstValue)
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

    var skyImage: Image {
        switch self.skyCondition {
        case .clear:
            return Image(systemName: "sun.max")
        case .cloudy:
            return Image(systemName: "cloud.sun")
        case .overcast:
            return Image(systemName: "cloud")
        default:
            return Image(systemName: "questionmark")
        }
    }

}
