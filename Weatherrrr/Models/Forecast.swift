//
//  Forecast.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/9/25.
//

import SwiftUI

struct Forecast {
    let dateTime: Date
    var temperature: String
    var dailyHighTemp: String
    var dailyLowTemp: String
    var parcipitation: String
    var humidity: String
    var windVector: String
    var windSpeed: String
    var skyCondition: String

    init(dateTime: Date) {
        self.dateTime = dateTime
        self.temperature = "--"
        self.dailyHighTemp = "--"
        self.dailyLowTemp = "--"
        self.parcipitation = "--"
        self.humidity = "--"
        self.windVector = "--"
        self.windSpeed = "--"
        self.skyCondition = "--"
    }

    static let categoryKeyPaths: [String: WritableKeyPath<Forecast, String>] = [
            "PCP": \.parcipitation,
            "REH": \.humidity,
            "TMX": \.dailyHighTemp,
            "TMN": \.dailyLowTemp,
            "TMP": \.temperature,
            "VEC": \.windVector,
            "WSD": \.windSpeed,
            "SKY": \.skyCondition
        ]
}
