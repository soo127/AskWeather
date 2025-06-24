//
//  WeatherReport.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/17/25.
//

import SwiftUI
import CoreLocation

struct WeatherReport: Codable, Identifiable {

    let id: UUID
    let forecasts: [Forecast]
    let uvIndex: Int
    let airDiffusionIndex: Int
    let airPollution: Int
    let address: String
    let areaCode: String
    let latitude: Double
    let longitude: Double
    let updatedAt: Date

    init(
        forecasts: [Forecast],
        uvIndex: Int,
        airDiffusionIndex: Int,
        airPollution: Int,
        address: String,
        areaCode: String,
        latitude: Double,
        longitude: Double
    ) {
        self.id = UUID()
        self.forecasts = forecasts
        self.uvIndex = uvIndex
        self.airDiffusionIndex = airDiffusionIndex
        self.airPollution = airPollution
        self.address = address
        self.areaCode = areaCode
        self.latitude = latitude
        self.longitude = longitude
        self.updatedAt = Date()
    }

}

extension WeatherReport {

    static let empty = WeatherReport(
        forecasts: [],
        uvIndex: 0,
        airDiffusionIndex: 0,
        airPollution: 0,
        address: "--",
        areaCode: "--",
        latitude: 0,
        longitude: 0
    )

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

}
