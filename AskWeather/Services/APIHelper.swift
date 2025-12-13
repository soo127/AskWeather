//
//  APIHelper.swift
//  AskWeather
//
//  Created by 이상수 on 6/8/25.
//

import SwiftUI

enum APIHelper {

    static func fetch<T: Decodable>(url: URL?) async throws -> T {
        guard let url else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        try Self.checkServiceError(data: data)
        let decoded = try JSONDecoder().decode(T.self, from: data)
        return decoded
    }

    static func fetch<T: Decodable>(request: URLRequest?) async throws -> T {
        guard let request else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoded = try JSONDecoder().decode(T.self, from: data)
        return decoded
    }

}

extension APIHelper {
    
    // 공공데이터 포털 api 서버 문제 (HTTP ROUTING ERROR)
    private static func checkServiceError(data: Data) throws {
        guard let string = String(data: data, encoding: .utf8) else {
            throw FetchError.noData
        }
        if string.contains("SERVICE ERROR") {
            throw URLError(.badServerResponse)
        }
    }
    
}
