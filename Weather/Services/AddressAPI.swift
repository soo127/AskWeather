//
//  AddressAPI.swift
//  Weather
//
//  Created by 이상수 on 6/5/25.
//

import SwiftUI
import CoreLocation

struct AddressAPI {

    static func fetchAddress(from coordinate: CLLocationCoordinate2D) async throws -> String? {

        let latitude = coordinate.latitude
        let longitude = coordinate.longitude
        let urlString = "https://dapi.kakao.com/v2/local/geo/coord2address.json?x=\(longitude)&y=\(latitude)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        let apiKey = Bundle.main.infoDictionary?["KAKAO_REST_API_KEY"] as? String ?? ""
        request.setValue("KakaoAK \(apiKey)", forHTTPHeaderField: "Authorization")

        let (data, _) = try await URLSession.shared.data(for: request)
        //print(String(data: data, encoding: .utf8) ?? "응답을 문자열로 변환 실패")
        let decoded = try JSONDecoder().decode(KakaoAddressResponse.self, from: data)

        guard let address = decoded.documents.first?.address else { return nil }
        return "\(address.region_1depth_name) \(address.region_2depth_name) \(address.region_3depth_name)"

    }

}

