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

    func loadAddress(for coordinate: CLLocationCoordinate2D) async {
        do {
            let address = try await AddressAPI.fetchAddress(from: coordinate)
            await MainActor.run {
                self.address = address
            }
        } catch {
            print("AddressManager error: \(error)")
        }
    }

}
