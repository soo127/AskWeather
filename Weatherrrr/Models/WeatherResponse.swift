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
        let category: Category
        let fcstDate: String
        let fcstTime: String
        let fcstValue: String
    }

    enum Category: String, Decodable {
        case temperature = "TMP"
        case humidity = "REH"
        case windSpeed = "WSD"
        case windVector = "VEC"
        case cloud = "SKY"
        case precipitationType = "PTY"
        case parcipitation = "PCP"
        case dailyHighTemp = "TMX"
        case dailyLowTemp = "TMN"
        case unknown

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let rawValue = try container.decode(String.self)
            self = Category(rawValue: rawValue) ?? .unknown
        }
    }

}
