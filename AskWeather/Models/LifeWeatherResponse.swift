//
//  LifeWeatherResponse.swift
//  AskWeather
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
        let current: Int?
        let after3Hours: Int?
        enum CodingKeys: String, CodingKey {
            case current = "h0"
            case after3Hours = "h3"
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.current = try? DecodingHelper.toInt(from: container, forKey: .current)
            self.after3Hours = try? DecodingHelper.toInt(from: container, forKey: .after3Hours)
        }
    }
    
}
