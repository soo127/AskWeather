//
//  ForecastBundle.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/17/25.
//

import SwiftUI
import CoreLocation

struct ForecastBundle: Identifiable {

    let id = UUID()
    let forecasts: [Forecast]
    let uvIndex: Int
    let airDiffusionIndex: Int
    let airPollution: Int
    let address: String
    let areaCode: String
    let coordinate: CLLocationCoordinate2D

}

extension ForecastBundle {

    static let empty = ForecastBundle(
        forecasts: [],
        uvIndex: .zero,
        airDiffusionIndex: .zero,
        airPollution: .zero,
        address: "--",
        areaCode: "--",
        coordinate: .init()
    )

}
