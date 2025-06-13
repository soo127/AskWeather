//
//  AirPollutionAPI.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/11/25.
//

import SwiftUI

struct AirPollutionAPI {

    static func fetch() async throws -> AirPollutionResponse.Item? {
        let fetched: AirPollutionResponse = try await APIHelper.fetch(url: url())
        return fetched.response.body.items.first
    }

}

extension AirPollutionAPI {

    private static func url() -> URL? {
        let param = params()
            .map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
        let url = Constants.baseURL + "?" + param
        return URL(string: url)
    }

    private static func params() -> [String: Any] {
        [
            "serviceKey": Self.apiKey,
            "pageNo": 1,
            "numOfRows": 1000,
            "returnType": "json",
            "itemCode": "PM10",
            "dataGubun": "HOUR",
            "searchCondition": "WEEK"
        ]
    }

    private static var apiKey: String {
        "D6isDBPO8K02ZbuWvj5rekfrmgpuAujejX8OZpMaz0aEwWU070S8US0pordpKMnu0qlD1NS8r83w7FqLWLgGOg%3D%3D"
    }

}
extension AirPollutionAPI {

    fileprivate enum Constants {
        static let baseURL = "http://apis.data.go.kr/B552584/ArpltnStatsSvc/getCtprvnMesureLIst"
    }
}
