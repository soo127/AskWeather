//
//  LifeWeatherIndexViewModel.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/10/25.
//

import SwiftUI
import CoreLocation

class LifeWeatherViewModel: ObservableObject {

    @Published var uvIndex: String?
    @Published var airDiffusionIndex: String?

    func load(for coordinate: CLLocationCoordinate2D) async {
        do {
            let areaCode = try await AddressAPI.fetchAreaCode(from: coordinate)
            let uv = try await LifeWeatherIndexAPI.fetch(for: .uv, areaCode: areaCode)
            let air = try await LifeWeatherIndexAPI.fetch(for: .airDiffusion, areaCode: areaCode)

            await MainActor.run {
                process(uvByHour: uv, airByHour: air)
            }
        } catch {
            print("LifeWeather Fetch Error: \(error)")
        }
    }

    private func process(uvByHour: LifeWeatherItem?, airByHour: LifeWeatherItem?) {
        uvIndex = uvByHour?.current
        airDiffusionIndex = airByHour?.after3Hours
    }

    var uvIndexLevel: String? {
        guard let value = uvIndex, let intValue = Int(value) else { return nil }
        switch intValue {
        case 0...2:
            return "낮음"
        case 3...5:
            return "보통"
        case 6...7:
            return "높음"
        case 8...10:
            return "매우 높음"
        default:
            return "위험"
        }
    }

    var airIndexLevel: String? {
        guard let value = airDiffusionIndex, let intValue = Int(value) else { return nil }
        switch intValue {
        case 25:
            return "낮음"
        case 50:
            return "보통"
        case 75:
            return "높음"
        default:
            return "매우 높음"
        }
    }

}
