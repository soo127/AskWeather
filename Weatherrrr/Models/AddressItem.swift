//
//  AddressItem.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/9/25.
//

struct KakaoAddressResponse: Codable {
    let documents: [Document]
}

struct Document: Codable {
    let address: Address
}

struct Address: Codable {
    let address_name: String
    let region_1depth_name: String
    let region_2depth_name: String
    let region_3depth_name: String
}
