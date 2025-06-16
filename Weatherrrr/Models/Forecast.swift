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
    var dailyHighTemp: String
    var dailyLowTemp: String
    var parcipitation: String
    var humidity: String
    var windVector: String
    var windSpeed: String
    var skyCondition: String

    init(date: Date) {
        self.date = date
        self.temperature = .zero
        self.dailyHighTemp = "--"
        self.dailyLowTemp = "--"
        self.parcipitation = "--"
        self.humidity = "--"
        self.windVector = "--"
        self.windSpeed = "--"
        self.skyCondition = "--"
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
            self.humidity = item.fcstValue
        case .dailyHighTemp:
            self.dailyHighTemp = item.fcstValue
        case .dailyLowTemp:
            self.dailyLowTemp = item.fcstValue
        case .temperature:
            self.temperature = Int(item.fcstValue) ?? .zero
        case .windVector:
            self.windVector = item.fcstValue
        case .windSpeed:
            self.windSpeed = item.fcstValue
        case .skyCondition:
            self.skyCondition = item.fcstValue
        case .unknown:
            break
        }
    }

}

extension Forecast {

    var skyImage: Image {
        switch self.skyCondition {
        case "1":
            return Image(systemName: "sun.max")
        case "3":
            return Image(systemName: "cloud.sun")
        case "4":
            return Image(systemName: "cloud")
        default:
            return Image(systemName: "questionmark")
        }
    }

}
