//
//  WeatherManager.swift
//  Weather
//
//  Created by 이상수 on 6/2/25.
//

import SwiftUI
import CoreLocation

class WeatherManager: ObservableObject {

    @Published var items: [WeatherItem]?

    func fetchWeather(location: CLLocationCoordinate2D) async {
        do {
            let items = try await WeatherAPI.fetchWeather(from: location)
            await MainActor.run { self.items = items }
        } catch {
            print("WeatherManager error: \(error)")
        }
    }

}
