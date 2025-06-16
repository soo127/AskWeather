//
//  Forecast.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/9/25.
//

import SwiftUI

// TODO: - 온도 Double, Int
struct Forecast {

    let date: Date
    var temperature: Int
    var dailyHighTemp: Double
    var dailyLowTemp: Double
    var parcipitation: String
    var humidity: Int
    var windVector: Int
    var windSpeed: Double
    var skyCondition: SkyCondition

    init(date: Date) {
        self.date = date
        self.temperature = .zero
        self.dailyHighTemp = .zero
        self.dailyLowTemp = .zero
        self.parcipitation = "--"
        self.humidity = .zero
        self.windVector = .zero
        self.windSpeed = .zero
        self.skyCondition = .clear
    }

    enum SkyCondition: String {
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
            self.parcipitation = item.fcstValue
        case .humidity:
            self.humidity = Int(item.fcstValue) ?? .zero
        case .dailyHighTemp:
            self.dailyHighTemp = Double(item.fcstValue) ?? .zero
        case .dailyLowTemp:
            self.dailyLowTemp = Double(item.fcstValue) ?? .zero
        case .temperature:
            self.temperature = Int(item.fcstValue) ?? .zero
        case .windVector:
            self.windVector = Int(item.fcstValue) ?? .zero
        case .windSpeed:
            self.windSpeed = Double(item.fcstValue) ?? .zero
        case .skyCondition:
            self.skyCondition = SkyCondition(from: item.fcstValue)
        case .unknown:
            break
        }
    }

}

extension Forecast {

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
