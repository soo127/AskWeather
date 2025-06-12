//
//  AirPollutionManager.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/11/25.
//

import SwiftUI
import CoreLocation

class AirPollutionManager {

    @Published var airPollution: String?

    @MainActor
    func loadAirPollution(for coordinate: CLLocationCoordinate2D) async {
        do {
            let nationalAir = try await AirPollutionAPI.fetchAirPollution()
            let area = try await AddressAPI.fetchAddress(from: coordinate)
            airPollution = AirPollutionMapper.value(area: area, in: nationalAir)
        } catch {
            print("AirPollution Fetch Error: \(error)")
        }
    }

    var pollutionLevel: String? {
        guard let airPollution = airPollution,
              let amount = Int(airPollution) else {
            return nil
        }
        switch amount {
        case 0...30:
            return "좋음"
        case 31...80:
            return "보통"
        case 81...150:
            return "나쁨"
        default:
            return "매우 나쁨"
        }
    }

}
