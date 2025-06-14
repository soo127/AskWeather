//
//  AppCoordinator.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/13/25.
//

import SwiftUI
import CoreLocation

final class AppCoordinator: ObservableObject {

    let weatherViewModel: WeatherViewModel
    let addressManager: AddressManager
    private let locationManager: LocationManager

    init() {
        self.weatherViewModel = WeatherViewModel()
        self.addressManager = AddressManager()
        self.locationManager = LocationManager()
        setupLocationHandlers()
    }

    private func setupLocationHandlers() {
        locationManager.onLocationUpdate = { [weak self] coordinate in
            Task { await self?.loadLocationData(for: coordinate) }
        }
    }

    func loadLocationData(for coordinate: CLLocationCoordinate2D) async {
        await weatherViewModel.load(for: coordinate)
        await addressManager.load(for: coordinate)
    }

}
