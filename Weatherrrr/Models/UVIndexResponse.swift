//
//  UVIndexResponse.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/10/25.
//

struct UVIndexResponse: Codable {
    let response: UVIndexResponseBody
}

struct UVIndexResponseBody: Codable {
    let body: UVIndexBody
}

struct UVIndexBody: Codable {
    let items: UVIndexItems
}

struct UVIndexItems: Codable {
    let item: [UVIndexItem]
}

struct UVIndexItem: Codable {
    let areaNo: String
    let date: String
    let h0: String
    let h3: String
    let h6: String
    let h9: String
    let h12: String
    let h15: String
    let h18: String
    let h21: String
    let h24: String
}
