//
//  AirPollutionMapper.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/11/25.
//

enum AirPollutionMapper {

    static func value(area areaRawValue: String?, in item: AirPollutionResponse.Item?) -> String? {
        guard let areaRawValue,
              let area = Area.allCases.first(where: { areaRawValue.contains($0.rawValue) }),
              let item else {
            return nil
        }
        return item.value(area: area)
    }
    
}
