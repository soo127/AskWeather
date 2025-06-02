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
        let date = formatter.string(from: Date())

        formatter.dateFormat = "HH00"
        //let time = formatter.string(from: Date())
        let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String ?? ""

        let urlString = "https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?serviceKey=\(apiKey)&pageNo=1&numOfRows=10&dataType=JSON&base_date=\(date)&base_time=1100&nx=\(nx)&ny=\(ny)"

        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(WeatherResponse.self, from: data)

        return decoded.response.body.items
        
    }

}
