//
//  WeatherFormatter.swift
//  Weather
//
//  Created by 이상수 on 6/2/25.
//

struct WeatherFormatter {

    func skyDescription(code: String) -> String {
        switch code {
        case "1": return "맑음"
        case "3": return "구름 많음"
        case "4": return "흐림"
        default: return "알 수 없음"
        }
    }

    func ptyDescription(code: String) -> String {
        switch code {
        case "0": return "없음"
        case "1": return "비"
        case "2": return "비/눈"
        case "3": return "눈"
        case "4": return "소나기"
        default: return "알 수 없음"
        }
    }

}
