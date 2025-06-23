//
//  MapViewModel.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/19/25.
//

import SwiftUI
import CoreLocation
import MapKit

class MapViewModel: ObservableObject {

    @Published var menuType: MapMenuType = .temperature

    let koreaRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 36.5, longitude: 127.5),
        span: MKCoordinateSpan(latitudeDelta: 4.0, longitudeDelta: 4.0)
    )

    func select(type: MapMenuType) {
        menuType = type
    }

    func value(weatherReport: WeatherReport) -> Int {
        switch menuType {
        case .temperature:
            return WeatherFormatter.current(forecasts: weatherReport.forecasts)?.temperature ?? .zero
        case .airPollution:
            return weatherReport.airPollution
        case .uvIndex:
            return weatherReport.uvIndex
        }
    }

    func color(value: Int) -> Color {
        switch menuType {
        case .temperature:
            return WeatherFormatter.temperatureColor(value)
        case .airPollution:
            return WeatherFormatter.airPollutionColor(value)
        case .uvIndex:
            return WeatherFormatter.uvColor(value)
        }
    }

}
