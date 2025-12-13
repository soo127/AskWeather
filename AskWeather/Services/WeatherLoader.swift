//
//  WeatherLoader.swift
//  AskWeather
//
//  Created by 이상수 on 6/18/25.
//

import SwiftUI
import CoreLocation

enum WeatherLoader {

    static func load(coordinate: CLLocationCoordinate2D?, displayAddress: String? = nil) async throws -> WeatherReport {
        guard let coordinate else {
            throw FetchError.noData
        }
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
            address: displayAddress ?? address,
            areaCode: areaCode,
            latitude: coordinate.latitude,
            longitude: coordinate.longitude
        )
    }
    
    /// (필요한 경우 사용) 공공 데이터 포털의 서버 문제 -> 일정 시간 후 재시도할 경우 대부분 해결
    static func loadWithRetry(coordinate: CLLocationCoordinate2D?, displayAddress: String? = nil) async throws -> WeatherReport {
        do {
            return try await load(coordinate: coordinate, displayAddress: displayAddress)
        } catch { // 필요에 따라 let urlError as URLError where urlError.code == .badServerResponse 등으로 구체화
            print("서버 문제로 인해 5초 후 로드를 다시 시도합니다.")
            try? await Task.sleep(nanoseconds: 10 * 500_000_000)
            return try await load(coordinate: coordinate, displayAddress: displayAddress)
        }
    }
 
}

extension WeatherLoader {
    
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
