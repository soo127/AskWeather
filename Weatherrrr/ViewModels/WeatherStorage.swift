//
//  WeatherStorage.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/17/25.
//

import SwiftUI
import CoreLocation

class WeatherStorage: ObservableObject {

    @Published private(set) var stored: [WeatherReport] = []

    @MainActor
    func store(coordinate: CLLocationCoordinate2D?) {
        Task {
            do {
                let weather = try await WeatherLoader.load(coordinate: coordinate)
                stored.append(weather)
            } catch {
                print("weatherstorage error: \(error)")
            }
        }
    }

}
