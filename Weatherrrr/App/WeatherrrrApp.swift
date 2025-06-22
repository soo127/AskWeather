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
            if let userLocation = locationManager.userLocation {
                ContentView(coordinate: userLocation)
                    .onAppear {
                        weatherStorage.store(coordinate: userLocation)
                    }
                    .environmentObject(weatherStorage)
            } else {
                ProgressView("현재 위치를 불러오는 중...")
            }
        }
    }

}
