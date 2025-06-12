//
//  LifeWeatherIndexAPI.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/10/25.
//

import SwiftUI
import CoreLocation

struct LifeWeatherIndexAPI {

    static func fetch(for type: LifeWeatherIndexType, areaCode: String?) async throws -> LifeWeatherItem? {
        guard let areaCode, let url = url(for: type, areaCode: areaCode) else {
            return nil
        }

        let response: LifeWeatherResponse = try await APIHelper.fetch(url: url)
        return response.response.body.items.item.first
    }

}

extension LifeWeatherIndexAPI {

    private static func url(for type: LifeWeatherIndexType, areaCode: String) -> URL? {
        let param = params(areaCode: areaCode)
            .map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")

        return URL(string: baseURL(for: type) + "?" + param)
    }

    private static func baseURL(for type: LifeWeatherIndexType) -> String {
        switch type {
        case .uv:
            return Constants.baseUVURL
        case .airDiffusion:
            return Constants.baseAirURL
        }
    }

    private static func params(areaCode: String) -> [String: Any] {
        [
            "serviceKey": Self.apiKey,
            "pageNo": 1,
            "numOfRows": 1000,
            "dataType": "JSON",
            "areaNo": areaCode,
            "time": hourKey()
        ]
    }

    private static func hourKey() -> String {
        let now = Date()
        let hour = (Calendar.current.component(.hour, from: now) / 3) * 3

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let dateString = formatter.string(from: now)

        return dateString + String(format: "%02d", hour)
    }

    private static var apiKey: String {
        "D6isDBPO8K02ZbuWvj5rekfrmgpuAujejX8OZpMaz0aEwWU070S8US0pordpKMnu0qlD1NS8r83w7FqLWLgGOg%3D%3D"
    }
    
}

extension LifeWeatherIndexAPI {

    fileprivate enum Constants {
        static let baseUVURL = "http://apis.data.go.kr/1360000/LivingWthrIdxServiceV4/getUVIdxV4"
        static let baseAirURL = "http://apis.data.go.kr/1360000/LivingWthrIdxServiceV4/getAirDiffusionIdxV4"
    }

}

