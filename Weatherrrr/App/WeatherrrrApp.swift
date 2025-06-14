//
//  WeatherrrrApp.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/8/25.
//

import SwiftUI

@main
struct WeatherrrrApp: App {

    @StateObject private var appCoordinator = AppCoordinator()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appCoordinator.weatherViewModel)
                .environmentObject(appCoordinator.addressManager)
        }
    }

}
