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

    init() {
        locationManager = LocationManager()
        kmaViewModel = KMAViewModel()
        addressManager = AddressManager()
        setupLocationCallback()
    }

    private func setupLocationCallback() {
        locationManager.onLocationUpdate = { [weak self] coordinate in
            Task {
                await self?.kmaViewModel.loadWeather(for: coordinate)
                await self?.addressManager.loadAddress(for: coordinate)
            }
        }
    }

}
