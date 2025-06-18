//
//  WeatherLoader.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/18/25.
//

import SwiftUI
import CoreLocation

enum WeatherLoader {

    static func load(coordinate: CLLocationCoordinate2D) async throws -> WeatherReport {
        let (address, areaCode) = try await AddressAPI.fetch(from: coordinate)

        async let nationalAir = AirPollutionAPI.fetch()
        async let uv = LifeWeatherIndexAPI.fetch(index: .uv, areaCode: areaCode)
        async let air = LifeWeatherIndexAPI.fetch(index: .airDiffusion, areaCode: areaCode)
        async let items = KMAAPI.fetch(coordinate: coordinate)

        guard let uv = try await uv.current,
              let airDiffusion = try await air.after3Hours,
              let airPollution = AirPollutionMapper.value(area: address, in: try await nationalAir) else {
            throw FetchError.noData
        }

        return WeatherReport(
            forecasts: makeForecasts(items: try await items),
            uvIndex: uv,
            airDiffusionIndex: airDiffusion,
            airPollution: airPollution,
            address: address,
            areaCode: areaCode,
            coordinate: coordinate
        )
    }

   private static func makeForecasts(items: [KMAAPI.Item]) -> [Forecast] {
        let itemsByDate: [Date: [KMAAPI.Item]] = items
            .reduce(into: [:]) { partialResult, item in
                let dateString = item.fcstDate + item.fcstTime
                guard let date = dateString.date() else {
                    return
                }
                let prevItems = partialResult[date] ?? []
                return partialResult[date] = (prevItems + [item])
            }

        let forecasts = itemsByDate
            .sorted { $0.key < $1.key }
            .map { (date, items) in
                var forecast = Forecast(date: date)
                forecast.update(items: items)
                return forecast
            }

        return forecasts
    }

}
