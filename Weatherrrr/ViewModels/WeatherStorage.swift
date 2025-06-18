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

    func store(bundle: WeatherReport) {
        stored.append(bundle)
    }

}
