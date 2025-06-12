//
//  AirPollutionMapper.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/11/25.
//

import SwiftUI

enum AirPollutionMapper {

    static func value(area: String?, in item: AirPollutionResponse.Item?) -> String? {
        guard let area = area, let item = item else {
            return nil
        }
        for (keyword, keyPath) in keyPaths {
            if area.contains(keyword) {
                return item[keyPath: keyPath]
            }
        }
        return nil
    }

    private static let keyPaths: [String: KeyPath<AirPollutionResponse.Item, String?>] = [
        "서울": \.seoul,
        "부산": \.busan,
        "대구": \.daegu,
        "인천": \.incheon,
        "광주": \.gwangju,
        "대전": \.daejeon,
        "울산": \.ulsan,
        "경기": \.gyeonggi,
        "강원": \.gangwon,
        "충북": \.chungbuk,
        "충남": \.chungnam,
        "전북": \.jeonbuk,
        "전남": \.jeonnam,
        "경북": \.gyeongbuk,
        "경남": \.gyeongnam,
        "제주": \.jeju,
        "세종": \.sejong
    ]
    
}

