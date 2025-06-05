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
    @StateObject private var addressManager = AddressManager()

    var body: some Scene {

        WindowGroup {
            ContentView()
                .environmentObject(locationManager)
                .environmentObject(weatherManager)
                .environmentObject(addressManager)
                .task {
                    if let location = locationManager.userLocation {
                        await weatherManager.fetchWeather(location: location)
                        await addressManager.fetchAddress(location: location)
                    }
                }
        }

    }

}
