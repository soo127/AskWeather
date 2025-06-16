//
//  LifeWeatherIndexAPI.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/10/25.
//

import SwiftUI
import CoreLocation

struct LifeWeatherIndexAPI {

    static func fetch(index: LifeWeatherIndex, areaCode: String?) async throws -> LifeWeatherIndexAPI.Item? {
        guard let areaCode, let url = url(index: index, areaCode: areaCode) else {
            return nil
        }

        let response: LifeWeatherResponse = try await APIHelper.fetch(url: url)
        return response.response.body.items.item.first
    }

}

extension LifeWeatherIndexAPI {

    private static func url(index: LifeWeatherIndex, areaCode: String) -> URL? {
        let param = params(areaCode: areaCode)
            .map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")

        return URL(string: baseURL(index: index) + "?" + param)
    }

    private static func baseURL(index: LifeWeatherIndex) -> String {
        switch index {
        case .uv:
            return Constants.baseUVURL
        case .airDiffusion:
            return Constants.baseAirURL
        }
    }

    private static func params(areaCode: String) -> [String: Any] {
        [
            "serviceKey": Constants.apiKey,
            "pageNo": 1,
            "numOfRows": 1000,
            "dataType": "JSON",
            "areaNo": areaCode,
            "time": hourKey()
        ]
    }

    private static func hourKey() -> String {
        let now = Date()
        let hour: Int = (Calendar.current.component(.hour, from: now) / 3) * 3
        return now.dateString() + String(format: "%02d", hour)
    }

}

extension LifeWeatherIndexAPI {

    fileprivate enum Constants {
        static let apiKey = "D6isDBPO8K02ZbuWvj5rekfrmgpuAujejX8OZpMaz0aEwWU070S8US0pordpKMnu0qlD1NS8r83w7FqLWLgGOg%3D%3D"
        static let baseUVURL = "http://apis.data.go.kr/1360000/LivingWthrIdxServiceV4/getUVIdxV4"
        static let baseAirURL = "http://apis.data.go.kr/1360000/LivingWthrIdxServiceV4/getAirDiffusionIdxV4"
    }

}
