//
//  WeatherResponse.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/8/25.
//

extension KMAAPI {

    struct WeatherResponse: Decodable {
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
        let baseDate: String
        let baseTime: String
        let category: Category
        let fcstDate: String
        let fcstTime: String
        let fcstValue: String
        let nx: Int
        let ny: Int
    }

    enum Category: String, Decodable {
        case parcipitation = "PCP"
        case humidity = "REH"
        case dailyHighTemp = "TMX"
        case dailyLowTemp = "TMN"
        case temperature = "TMP"
        case windVector = "VEC"
        case windSpeed = "WSD"
        case skyCondition = "SKY"
        case unknown

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let rawValue = try container.decode(String.self)
            self = Category(rawValue: rawValue) ?? .unknown
        }
    }

}
