//
//  WeatherItem.swift
//  Weather
//
//  Created by 이상수 on 6/2/25.
//

import SwiftUI

struct WeatherResponse: Codable {
    let response: Response
}

struct Response: Codable {
    let header: Header
    let body: Body
}

struct Header: Codable {
    let resultCode: String
    let resultMsg: String
}

struct Body: Codable {
    let dataType: String
    let items: ItemWrapper
    let pageNo: Int
    let numOfRows: Int
    let totalCount: Int
}

struct ItemWrapper: Codable {
    let item: [WeatherItem]
}

struct WeatherItem: Codable {
    let baseDate: String
    let baseTime: String
    let category: String
    let fcstDate: String
    let fcstTime: String
    let fcstValue: String
    let nx: Int
    let ny: Int
}

