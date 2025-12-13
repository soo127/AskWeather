//
//  AddressAPI.swift
//  AskWeather
//
//  Created by 이상수 on 6/9/25.
//

import SwiftUI
import CoreLocation

struct AddressAPI {

    static func fetch(from coordinate: CLLocationCoordinate2D) async throws -> (address: String, areaCode: String) {
        let response: AddressResponse = try await APIHelper.fetch(request: request(coordinate: coordinate))
        guard let fetched = response.documents.last else {
            throw FetchError.noData
        }
        return (fetched.address_name, fetched.code)
    }

}

extension AddressAPI {

    private static func request(coordinate: CLLocationCoordinate2D) -> URLRequest? {
        let lat = coordinate.latitude
        let lon = coordinate.longitude
        guard let url = Self.url(lat: lat, lon: lon) else {
            return nil
        }

        var request = URLRequest(url: url)
        request.setValue("KakaoAK \(Constants.apiKey)", forHTTPHeaderField: "Authorization")
        return request
    }

    private static func url(lat: Double, lon: Double) -> URL? {
        let param = params(lat: lat, lon: lon)
            .map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
        let url = Constants.baseURL + "?" + param
        return URL(string: url)
    }

    private static func params(lat: Double, lon: Double) -> [String: Any] {
        [
            "x": lon,
            "y": lat
        ]
    }

}

extension AddressAPI {

    fileprivate enum Constants {
        static let apiKey = "078c1b349c8cc258f38f2eb91d60e196"
        static let baseURL = "https://dapi.kakao.com/v2/local/geo/coord2regioncode.json"
    }

}
