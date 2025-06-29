//
//  WidgetWeather.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/28/25.
//

import SwiftUI

struct WidgetWeather: Codable {
    let temperature: Int
    let windSpeed: Double
    let address: String
    let skyName: String
    let uvLevel: String
    let pollutionLevel: String
}

extension WidgetWeather {

    static let empty = WidgetWeather(
        temperature: .zero,
        windSpeed: .zero,
        address: "--",
        skyName: "cloud",
        uvLevel: "--",
        pollutionLevel: "--"
    )

}
