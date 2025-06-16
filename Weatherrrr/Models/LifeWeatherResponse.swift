//
//  LifeWeatherResponse.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/10/25.
//

extension LifeWeatherIndexAPI {

    struct LifeWeatherResponse: Decodable {
        let response: Response
    }

    struct Response: Decodable {
        let body: Body
    }

    struct Body: Decodable {
        let items: Items
    }

    struct Items: Decodable {
        let item: [Item]
    }

    struct Item: Decodable {
        let current: String?
        let after3Hours: String?
        enum CodingKeys: String, CodingKey {
            case current = "h0"
            case after3Hours = "h3"
        }
    }
    
}
