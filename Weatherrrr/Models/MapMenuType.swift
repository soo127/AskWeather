//
//  MapMenuType.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/19/25.
//

import SwiftUI

enum MapMenuType {
    case temperature
    case airPollution
    case uvIndex
}

extension MapMenuType {
    
    var legendValues: [Int] {
        switch self {
        case .temperature:
            return [0, 10, 20, 30, 40]
        case .airPollution:
            return [0, 30, 80, 150]
        case .uvIndex:
            return [0, 3, 6, 8, 11]
        }
    }

    var legendColors: [Color] {
        switch self {
        case .temperature:
            return [.blue, .cyan, .green, .orange, .red]
        case .airPollution:
            return [.blue, .green, .yellow, .red]
        case .uvIndex:
            return [.green, .yellow, .orange, .red, .purple]
        }
    }

    var title: String {
        switch self {
        case .temperature:
            return "기온 (°C)"
        case .airPollution:
            return "미세먼지 (㎍/㎥)"
        case .uvIndex:
            return "자외선 지수"
        }
    }
    
}

