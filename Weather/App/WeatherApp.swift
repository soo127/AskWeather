//
//  WeatherApp.swift
//  Weather
//
//  Created by 이상수 on 5/27/25.
//

import SwiftUI

@main
struct WeatherApp: App {

    @StateObject private var locationManager = LocationManager()
    @StateObject private var weatherManager = WeatherManager()

    var body: some Scene {

        WindowGroup {
            ContentView()
                .environmentObject(locationManager)
                .environmentObject(weatherManager)
                .task {
                    if let location = locationManager.userLocation {
                        await weatherManager.fetchWeather(location: location)
                    }
                }
        }

    }

}
