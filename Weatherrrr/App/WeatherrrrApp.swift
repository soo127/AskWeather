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
            if weatherStorage.isReady {
                ContentView(report: weatherStorage.currentWeather)
                    .environmentObject(weatherStorage)
            } else {
                ProgressView("현재 위치를 불러오는 중...")
                    .onChange(of: locationManager.didFetch) {
                        weatherStorage.scheduleUpdate(coordinate: locationManager.userLocation)
                    }
            }
        }
    }

}
