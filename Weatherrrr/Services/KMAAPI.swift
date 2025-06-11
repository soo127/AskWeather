//
//  KMAAPI.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/8/25.
//

import SwiftUI
import CoreLocation

struct KMAAPI {

    static func fetchWeather(from coordinate: CLLocationCoordinate2D) async throws -> [KMAItem] {
        let (nx, ny) = GridConverter.toGrid(from: coordinate)
        let fetched: KMAResponse = try await APIHelper.fetch(url: Self.url(nx: nx, ny: ny))
        return fetched.response.body.items.item
    }

}

extension KMAAPI {

    private static func url(nx: Int, ny: Int) -> URL? {
        let param = params(nx: nx, ny: ny)
            .map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
        let url = Constants.baseURL + "?" + param
        return URL(string: url)
    }

    private static func params(nx: Int, ny: Int) -> [String: Any] {
        [
            "serviceKey": Self.apiKey,
            "pageNo": 1,
            "numOfRows": 1000,
            "dataType": "JSON",
            "base_date": Self.baseDate,
            "base_time": 2300,
            "nx": nx,
            "ny": ny
        ]
    }

    private static var baseDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let yesterday =  Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        return formatter.string(from: yesterday)
    }

    private static var apiKey: String {
        "D6isDBPO8K02ZbuWvj5rekfrmgpuAujejX8OZpMaz0aEwWU070S8US0pordpKMnu0qlD1NS8r83w7FqLWLgGOg%3D%3D"
    }

}

extension KMAAPI {

    fileprivate enum Constants {
        static let baseURL = "https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst"
    }

}
