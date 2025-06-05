//
//  WeatherAPI.swift
//  Weather
//
//  Created by 이상수 on 6/2/25.
//

import SwiftUI
import CoreLocation

struct WeatherAPI {

    static func fetchWeather(from coordinate: CLLocationCoordinate2D) async throws -> [WeatherItem] {

        let (nx, ny) = GridConverter.toGrid(from: coordinate)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let yesterday =  Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let date = formatter.string(from: yesterday)

        let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String ?? ""
        let urlString = "https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?serviceKey=\(apiKey)&pageNo=1&numOfRows=1000&dataType=JSON&base_date=\(date)&base_time=2300&nx=\(nx)&ny=\(ny)"

        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(WeatherResponse.self, from: data)

        return decoded.response.body.items.item

    }

}
