//
//  AddressManager.swift
//  Weather
//
//  Created by 이상수 on 6/5/25.
//

import SwiftUI
import CoreLocation

class AddressManager: ObservableObject {

    @Published var address: String?

    func fetchAddress(location: CLLocationCoordinate2D) async {
        do {
            let address = try await AddressAPI.fetchAddress(from: location)
            await MainActor.run {
                self.address = address
            }
        } catch {
            print("AddressManager error: \(error)")
        }
    }

}
