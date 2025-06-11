//
//  AirPollutionResponse.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/11/25.
//

struct AirPollutionResponse: Codable {

    let response: Response

    struct Response: Codable {
        let body: Body
    }

    struct Body: Codable {
        let items: [Item]
    }

    struct Item: Codable {
        let seoul: String
        let busan: String
        let daegu: String
        let incheon: String
        let gwangju: String
        let daejeon: String
        let ulsan: String
        let gyeonggi: String
        let gangwon: String
        let chungbuk: String
        let chungnam: String
        let jeonbuk: String
        let jeonnam: String
        let gyeongbuk: String
        let gyeongnam: String
        let jeju: String
        let sejong: String
    }

}
