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


    func select(type: MapMenuType) {
        menuType = type
    }

    func value(weatherReport: WeatherReport) -> Int {
        switch menuType {
        case .temperature:
            return ForecastProcessor.current(forecasts: weatherReport.forecasts)?.temperature ?? .zero
        case .airPollution:
            return weatherReport.airPollution
        case .uvIndex:
            return weatherReport.uvIndex
        }
    }

    func color(value: Int) -> Color {
        switch menuType {
        case .temperature:
            return WeatherFormatter.temperatureColor(for: value)
        case .airPollution:
            return WeatherFormatter.airPollutionColor(for: value)
        case .uvIndex:
            return WeatherFormatter.uvColor(for: value)
        }
    }

}

extension MapViewModel {
    
    static let koreaRegion = MKCoordinateRegion (
        center: CLLocationCoordinate2D(latitude: 36.0, longitude: 127.8),
        span: MKCoordinateSpan(latitudeDelta: 4.0, longitudeDelta: 4.0)
    )
    
    static var cameraBounds: MapCameraBounds {
        MapCameraBounds(
            centerCoordinateBounds: koreaRegion,
            minimumDistance: 2000,
            maximumDistance: 1700000
        )
    }
    
}
