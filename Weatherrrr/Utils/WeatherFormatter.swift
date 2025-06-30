//
//  WeatherFormatter.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/19/25.
//

import SwiftUI

enum WeatherFormatter {

    static func pollutionLevel(for value: Int) -> String {
        switch value {
        case 0...30:
            return "좋음"
        case 31...80:
            return "보통"
        case 81...150:
            return "나쁨"
        default:
            return "매우 나쁨"
        }
    }

    static func airPollutionColor(_ airPollution: Int) -> Color {
        switch airPollution {
        case 0...30:
            return .blue
        case 31...80:
            return .green
        case 81...150:
            return .yellow
        default:
            return .red
        }
    }

    static func uvLevel(for value: Int) -> String {
        switch value {
        case 0...2:
            return "낮음"
        case 3...5:
            return "보통"
        case 6...7:
            return "높음"
        case 8...10:
            return "매우 높음"
        default:
            return "위험"
        }
    }

    static func uvColor(_ uvIndex: Int) -> Color {
        switch uvIndex {
        case 0...2:
            return .green
        case 3...5:
            return .yellow
        case 6...7:
            return .orange
        case 8...10:
            return .red
        default:
            return .purple
        }
    }

    static func airDiffusionLevel(for value: Int) -> String {
        switch value {
        case 25:
            return "낮음"
        case 50:
            return "보통"
        case 75:
            return "높음"
        default:
            return "매우 높음"
        }
    }

    static func temperatureColor(_ temperature: Int) -> Color {
        switch temperature {
        case ..<0:
            return .blue
        case 0..<10:
            return .cyan
        case 10..<20:
            return .green
        case 20..<30:
            return .orange
        default:
            return .red
        }
    }

}
