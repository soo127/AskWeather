//
//  LifeWeatherIndexAPI.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/10/25.
//

import SwiftUI
import CoreLocation

struct LifeWeatherIndexAPI {

    static func fetchUVIndex(from areaCode: String) async throws -> UVIndexItem? {
        let fetched: UVIndexResponse = try await APIHelper.fetch(url: Self.url(areaCode: areaCode))
        return fetched.response.body.items.item.first
    }

}

extension LifeWeatherIndexAPI {

    private static func url(areaCode: String) -> URL? {
        let param = params(areaCode: areaCode)
            .map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
        let url = Constants.baseURL + "?" + param
        return URL(string: url)
    }

    private static func params(areaCode: String) -> [String: Any] {
        [
            "serviceKey": Self.apiKey,
            "pageNo": 1,
            "numOfRows": 1000,
            "dataType": "JSON",
            "areaNo": areaCode,
            "time": 2025061000
        ]
    }

    private static var apiKey: String {
        "D6isDBPO8K02ZbuWvj5rekfrmgpuAujejX8OZpMaz0aEwWU070S8US0pordpKMnu0qlD1NS8r83w7FqLWLgGOg%3D%3D"
    }
    
}

extension LifeWeatherIndexAPI {

    fileprivate enum Constants {
        static let baseURL = "http://apis.data.go.kr/1360000/LivingWthrIdxServiceV4/getUVIdxV4"
    }

}
