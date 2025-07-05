//
//  AirPollutionAPI.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/11/25.
//

import SwiftUI

struct AirPollutionAPI {

    static func fetch() async throws -> AirPollutionAPI.Item {
        let response: AirPollutionResponse = try await APIHelper.fetch(url: url())
        print(url())
        guard let fetched = response.response.body.items.first else {
            print("실패........")
            throw FetchError.noData
        }
        return fetched
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
            "serviceKey": Constants.apiKey,
            "pageNo": 1,
            "numOfRows": 1,
            "returnType": "json",
            "itemCode": "PM10",
            "dataGubun": "HOUR",
            "searchCondition": "WEEK"
        ]
    }

}

extension AirPollutionAPI {

    fileprivate enum Constants {
        static let apiKey = "D6isDBPO8K02ZbuWvj5rekfrmgpuAujejX8OZpMaz0aEwWU070S8US0pordpKMnu0qlD1NS8r83w7FqLWLgGOg%3D%3D"
        static let baseURL = "https://apis.data.go.kr/B552584/ArpltnStatsSvc/getCtprvnMesureLIst"
    }
}
