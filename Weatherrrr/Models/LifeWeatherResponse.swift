//
//  LifeWeatherResponse.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/10/25.
//

struct LifeWeatherResponse: Codable {
    let response: LifeWeatherResponseBody
}

struct LifeWeatherResponseBody: Codable {
    let body: LifeWeatherBody
}

struct LifeWeatherBody: Codable {
    let items: LifeWeatherItems
}

struct LifeWeatherItems: Codable {
    let item: [LifeWeatherItem]
}

struct LifeWeatherItem: Codable {

    let current: String?
    let after3Hours: String?
    enum CodingKeys: String, CodingKey {
        case current = "h0"
        case after3Hours = "h3"
    }
    
}
