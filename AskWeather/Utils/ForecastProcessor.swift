//
//  ForecastProcessor.swift
//  AskWeather
//
//  Created by 이상수 on 6/23/25.
//

import SwiftUI

enum ForecastProcessor {

    static func current(forecasts: [Forecast]) -> Forecast? {
        forecasts.last(where: { $0.date <= Date() })
    }

}

// MARK: - icon in hourlyForecast

extension ForecastProcessor {

    static func skyName(forecast: Forecast) -> String {
        let isNight = forecast.date.isNight()

        switch forecast.precipitationType {
        case .rain, .shower:
            return "cloud.rain"
        case .snow:
            return "cloud.snow"
        case .sleet:
            return "cloud.sleet"
        case .none:
            return cloudName(cloud: forecast.cloud, isNight: isNight)
        case .unknown:
            return "questionmark"
        }
    }

    private static func cloudName(cloud: Forecast.CloudCondition, isNight: Bool) -> String {
        switch cloud {
        case .clear:
            return isNight ? "moon.stars" : "sun.max"
        case .cloudy:
            return isNight ? "cloud.moon" : "cloud.sun"
        case .overcast:
            return "cloud"
        case .unknown:
            return "questionmark"
        }
    }

}

// MARK: - background

extension ForecastProcessor {

    static func backgroundImg(forecasts: [Forecast]) -> Image {
        guard let current = Self.current(forecasts: forecasts) else {
            return Image("cloudy")
        }
        let isNight = current.date.isNight()

        switch current.precipitationType {
        case .rain, .shower:
            return Image(isNight ? "rain.night" : "rain")
        case .snow:
            return Image(isNight ? "snow.night" : "snow")
        case .sleet:
            return Image(isNight ? "rain.night" : "sleet") // sleet.night 대체
        case .none:
            return cloudBackgroundImage(cloud: current.cloud, isNight: isNight)
        case .unknown:
            return Image("clear.night")
        }
    }

    private static func cloudBackgroundImage(cloud: Forecast.CloudCondition, isNight: Bool) -> Image {
        switch cloud {
        case .clear:
            return Image(isNight ? "clear.night" : "clear")
        case .cloudy:
            return Image(isNight ? "cloudy.night" : "cloudy")
        case .overcast:
            return Image(isNight ? "overcast.night" : "overcast")
        case .unknown:
            return Image("clear.night")
        }
    }

}

// MARK: - daily weather icon

extension ForecastProcessor {

    /// rain > snow > sleet 순, 강수가 없는 날이면 cloudCondition에 의해 결정
    static func dailySkyIcon(forecasts: [Forecast], after: Int) -> Image {
        guard let targetDate = Calendar.current.date(byAdding: .day, value: after, to: Date()) else {
            return Image(systemName: "questionmark")
        }
        let dayForecasts = forecasts.filter {
            Calendar.current.isDate($0.date, inSameDayAs: targetDate)
        }

        if let precipitationIcon = dailyPrecipitationIcon(forecasts: dayForecasts) {
            return precipitationIcon
        }
        return dailyCloudIcon(forecasts: dayForecasts)
    }

    private static func dailyPrecipitationIcon(forecasts: [Forecast]) -> Image? {
        let priority: [Forecast.PrecipitationType] = [.shower, .rain, .snow, .sleet]

        for type in priority {
            if forecasts.contains(where: { $0.precipitationType == type }) {
                switch type {
                case .shower, .rain: return Image(systemName: "cloud.rain")
                case .snow: return Image(systemName: "cloud.snow")
                case .sleet: return Image(systemName: "cloud.sleet")
                default: continue
                }
            }
        }
        return nil
    }

    private static func dailyCloudIcon(forecasts: [Forecast]) -> Image {
        var clear = 0
        var cloudy = 0
        var overcast = 0

        for forecast in forecasts {
            switch forecast.cloud {
            case .clear: clear += 1
            case .cloudy: cloudy += 1
            case .overcast: overcast += 1
            case .unknown: continue
            }
        }
        let maxCount = max(clear, cloudy, overcast)
        switch maxCount {
        case clear: return Image(systemName: "sun.max")
        case cloudy: return Image(systemName: "cloud.sun")
        case overcast: return Image(systemName: "cloud")
        default: return Image(systemName: "questionmark")
        }
    }

}

// MARK: - daily low/high temp

extension ForecastProcessor {

    static func dailyTemp(forecasts: [Forecast], type: dailyTemperature, after: Int = 0) -> Double? {
        guard let targetDate = Calendar.current.date(byAdding: .day, value: after, to: Date()) else {
            return nil
        }
        let hour = type == .low ? 6 : 15
        let forecast = forecasts.first {
            Calendar.current.isDate($0.date, inSameDayAs: targetDate) &&
            Calendar.current.component(.hour, from: $0.date) == hour
        }
        return type == .low ? forecast?.dailyLowTemp : forecast?.dailyHighTemp
    }

    enum dailyTemperature {
        case low
        case high
    }

}
