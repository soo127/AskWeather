//
//  LocationManager.swift
//  Weather
//
//  Created by 이상수 on 5/29/25.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    @Published var userLocation: CLLocationCoordinate2D?
    @Published var authorizationStatus: CLAuthorizationStatus?
    private let manager = CLLocationManager()

    override init() {
        super.init()
        manager.delegate = self
        requestLocationPermission()
    }

    func requestLocationPermission() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            Task { @MainActor in
                self.userLocation = location.coordinate
            }
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        Task { @MainActor in
            self.authorizationStatus = manager.authorizationStatus
        }
    }

}
