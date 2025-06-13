//
//  AddressAPI.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/9/25.
//

import SwiftUI
import CoreLocation

struct AddressAPI {

    static func fetchAddress(from coordinate: CLLocationCoordinate2D) async throws -> String? {
        let fetched = try await fetchKakaoResponse(from: coordinate)
        return fetched.documents.last?.address_name
    }

    static func fetchAreaCode(from coordinate: CLLocationCoordinate2D) async throws -> String? {
        let fetched = try await fetchKakaoResponse(from: coordinate)
        return fetched.documents.last?.code
    }

    static func fetch(from coordinate: CLLocationCoordinate2D) async throws -> (area: String?, areaCode: String?) {
        let fetched = try await fetchKakaoResponse(from: coordinate)
        return (fetched.documents.last?.address_name, fetched.documents.last?.code)
    }

}

extension AddressAPI {

    private static func fetchKakaoResponse(from coordinate: CLLocationCoordinate2D) async throws -> KakaoAddressResponse {
        let lat = coordinate.latitude
        let lon = coordinate.longitude
        return try await APIHelper.fetch(request: request(lat: lat, lon: lon))
    }

    private static func request(lat: Double, lon: Double) -> URLRequest? {
        guard let url = Self.url(lat: lat, lon: lon) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.setValue("KakaoAK \(apiKey)", forHTTPHeaderField: "Authorization")
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

    private static var apiKey: String {
        "078c1b349c8cc258f38f2eb91d60e196"
    }

}

extension AddressAPI {

    fileprivate enum Constants {
        static let baseURL = "https://dapi.kakao.com/v2/local/geo/coord2regioncode.json"
    }

}

