//
//  MainViewModel.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/9/25.
//

import SwiftUI

class MainViewModel: ObservableObject {

    let locationManager: LocationManager
    let kmaViewModel: KMAViewModel
    let addressManager: AddressManager
    let lifeWeatherViewModel: LifeWeatherViewModel
    let airPollutionManager: AirPollutionManager

    init() {
        locationManager = LocationManager()
        kmaViewModel = KMAViewModel()
        addressManager = AddressManager()
        lifeWeatherViewModel = LifeWeatherViewModel()
        airPollutionManager = AirPollutionManager()
        setupLocationCallback()
    }

    private func setupLocationCallback() {
        locationManager.onLocationUpdate = { [weak self] coordinate in
            guard let self else {
                return
            }
            Task {
                await self.kmaViewModel.loadWeather(for: coordinate)
                await self.addressManager.load(for: coordinate)
                await self.lifeWeatherViewModel.load(for: coordinate)
                await self.airPollutionManager.loadAirPollution(for: coordinate)
            }
        }
    }

}
