//
//  AddressManager.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/9/25.
//

import SwiftUI
import CoreLocation

class AddressManager: ObservableObject {

    @Published var address: String?
    @Published var areaCode: String?

    @MainActor
    func load(for coordinate: CLLocationCoordinate2D) async {
        do {
            let address = try await AddressAPI.fetchAddress(from: coordinate)
            let areaCode = try await AddressAPI.fetchAreaCode(from: coordinate)
            self.address = address
            self.areaCode = areaCode
        } catch {
            print("AddressManager error: \(error)")
        }
    }

}
