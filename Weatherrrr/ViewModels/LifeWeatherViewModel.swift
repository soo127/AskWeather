//
//  LifeWeatherIndexViewModel.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/10/25.
//

import SwiftUI

class LifeWeatherViewModel: ObservableObject {

    @Published var uvIndex: [HourlyUVIndex] = []

    func loadUVIndex(using areaCode: String?) async {
        guard let areaCode else {
            return
        }
        do {
            let data = try await LifeWeatherIndexAPI.fetchUVIndex(from: areaCode)
            await MainActor.run {
                self.uvIndex = process(data: data)
            }
        } catch {
            print("UV Index Fetch Error: \(error)")
        }
    }

    private func process(data: UVIndexItem?) -> [HourlyUVIndex] {
        guard let data = data else { return [] }
        return [
            HourlyUVIndex(hour: 0, value: data.h0),
            HourlyUVIndex(hour: 3, value: data.h3),
            HourlyUVIndex(hour: 6, value: data.h6),
            HourlyUVIndex(hour: 9, value: data.h9),
            HourlyUVIndex(hour: 12, value: data.h12),
            HourlyUVIndex(hour: 15, value: data.h15),
            HourlyUVIndex(hour: 18, value: data.h18),
            HourlyUVIndex(hour: 21, value: data.h21)
        ]
    }

    var currentUVIndexValue: String? {
        let now = Calendar.current.component(.hour, from: Date())
        let blockHour = (now / 3) * 3
        return uvIndex.first(where: { $0.hour == blockHour })?.value
    }

    var currentUVIndexLevel: String? {
        guard let value = currentUVIndexValue, let intValue = Int(value) else { return nil }
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

}
