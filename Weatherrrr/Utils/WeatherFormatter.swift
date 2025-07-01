//
//  WeatherFormatter.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/19/25.
//

import SwiftUI

enum WeatherFormatter { }

//MARK: - airPollution

extension WeatherFormatter {
    
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
    
    static func pollutionAdvice(for value: Int) -> String {
        switch value {
        case 0...30:
            return "대기 상태가 좋습니다. 야외 활동하기에 적합해요."
        case 31...80:
            return "대기 상태가 무난합니다. 일반적인 활동은 문제 없어요."
        case 81...150:
            return "대기 오염이 다소 높습니다. 민감군은 마스크 착용을 권장해요."
        default:
            return "대기 오염이 매우 높습니다. 반드시 마스크를 착용하세요."
        }
    }

    static func airPollutionColor(for value: Int) -> Color {
        switch value {
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
    
}

//MARK: - uv

extension WeatherFormatter {
    
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
    
    static func uvAdvice(for value: Int) -> String {
        switch value {
        case 0...2:
            return "자외선이 낮습니다. 안심하고 외출하세요."
        case 3...5:
            return "자외선이 보통입니다. 외출 시 선크림을 챙기면 좋아요."
        case 6...7:
            return "자외선이 높습니다. 선크림, 모자, 선글라스를 착용하세요."
        case 8...10:
            return "자외선이 매우 높습니다. 장시간 외출은 피해주세요."
        default:
            return "자외선이 위험 수준입니다. 외출을 삼가는 것이 좋습니다."
        }
    }
    
    static func uvColor(for value: Int) -> Color {
        switch value {
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
    
}

//MARK: - airDiffusion

extension WeatherFormatter {
    
    static func airDiffusionLevel(for value: Int) -> String {
        switch value {
        case 0...25:
            return "낮음"
        case 50:
            return "보통"
        case 75:
            return "높음"
        default:
            return "매우 높음"
        }
    }
    
    static func airDiffusionAdvice(for value: Int) -> String {
        switch value {
        case 25:
            return "대기 흐름이 원활하지 않아요."
        case 50:
            return "대기 흐름이 무난해요."
        case 75:
            return "대기 흐름이 활발한 편입니다."
        default:
            return "대기가 매우 활발히 순환합니다."
        }
    }
    
}

//MARK: - temperature/ humidity

extension WeatherFormatter {
    
    static func temperatureColor(for value: Int) -> Color {
        switch value {
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
    
    static func humidityAdvice(for value: Int) -> String {
        switch value {
        case ..<30:
            return "건조한 날씨입니다. 피부와 호흡기 관리에 신경 쓰세요."
        case 30..<60:
            return "쾌적한 습도입니다. 야외 활동하기 좋은 날씨예요."
        case 60..<80:
            return "다소 습합니다. 실내 환기에 주의하세요."
        default:
            return "매우 습한 날씨입니다. 불쾌지수가 높아질 수 있어요."
        }
    }
    
}
