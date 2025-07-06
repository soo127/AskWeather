//
//  APIHelper.swift
//  Weatherrrr
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
