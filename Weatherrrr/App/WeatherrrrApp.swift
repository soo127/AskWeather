//
//  WeatherrrrApp.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/8/25.
//

import SwiftUI

@main
struct WeatherrrrApp: App {

    @StateObject private var locationManager = LocationManager()
    @StateObject private var weatherStorage = WeatherStorage()

    var body: some Scene {
        WindowGroup {
            ContentView(coordinate: locationManager.userLocation)
                .environmentObject(weatherStorage)
        }
    }

}
