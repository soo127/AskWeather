//
//  ForecastProcessor.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/23/25.
//

import SwiftUI

enum ForecastProcessor {

    static func current(forecasts: [Forecast]) -> Forecast? {
        forecasts.last(where: { $0.date <= Date() })
    }

    static func skyIcon(forecast: Forecast) -> Image {
        let isNight = forecast.date.isNight()

        switch forecast.precipitationType {
        case .rain, .shower:
            return Image(systemName: "cloud.rain")
        case .snow:
            return Image(systemName: "cloud.snow")
        case .sleet:
            return Image(systemName: "cloud.sleet")
        case .none:
            return cloudIcon(cloud: forecast.cloud, isNight: isNight)
        case .unknown:
            return Image(systemName: "questionmark")
        }
    }

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



}

extension ForecastProcessor {

    private static func cloudIcon(cloud: Forecast.CloudCondition, isNight: Bool) -> Image {
        switch cloud {
        case .clear:
            return Image(systemName: isNight ? "moon.stars" : "sun.max")
        case .cloudy:
            return Image(systemName: isNight ? "cloud.moon" : "cloud.sun")
        case .overcast:
            return Image(systemName: "cloud")
        case .unknown:
            return Image(systemName: "questionmark")
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
