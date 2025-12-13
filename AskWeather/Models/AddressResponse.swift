//
//  AddressResponse.swift
//  AskWeather
//
//  Created by 이상수 on 6/9/25.
//

extension AddressAPI {

    struct AddressResponse: Decodable {
        let documents: [Document]
    }

    struct Document: Decodable {
        let address_name: String
        let code: String // 행정구역 코드
    }

}
