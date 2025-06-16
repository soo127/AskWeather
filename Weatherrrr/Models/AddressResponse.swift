//
//  AddressResponse.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/9/25.
//

extension AddressAPI {

    struct Response: Decodable {
        let documents: [Document]
    }

    struct Document: Decodable {
        let address_name: String
        let code: String // 행정구역 코드
    }

}
