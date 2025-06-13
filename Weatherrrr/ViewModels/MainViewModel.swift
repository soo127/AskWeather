//
//  MainViewModel.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/9/25.
//

import SwiftUI

class MainViewModel: ObservableObject {

    let locationManager: LocationManager
    let weatherViewModel: WeatherViewModel
    let addressManager: AddressManager

    init() {
        locationManager = LocationManager()
        weatherViewModel = WeatherViewModel()
        addressManager = AddressManager()
        setupLocationCallback()
    }

    private func setupLocationCallback() {
        locationManager.onLocationUpdate = { [weak self] coordinate in
            guard let self else {
                return
            }
            Task {
                await self.weatherViewModel.load(for: coordinate)
                await self.addressManager.load(for: coordinate)
            }
        }
    }

}
