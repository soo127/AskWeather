//
//  AirPollutionMapper.swift
//  AskWeather
//
//  Created by 이상수 on 6/11/25.
//

enum AirPollutionMapper {

    static func value(area: String, in item: AirPollutionAPI.Item) -> Int? {
        guard let area = Area.allCases.first(where: { area.contains($0.rawValue) }) else {
            return nil
        }
        return item.value(area: area)
    }
    
}
