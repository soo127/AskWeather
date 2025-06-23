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
        switch forecast.precipitationType {
        case .rain, .shower:
            return Image(systemName: "cloud.rain")
        case .snow:
            return Image(systemName: "cloud.snow")
        case .sleet:
            return Image(systemName: "cloud.sleet")
        case .none:
            switch forecast.cloud {
            case .clear:
                return Image(systemName: "sun.max")
            case .cloudy:
                return Image(systemName: "cloud.sun")
            case .overcast:
                return Image(systemName: "cloud")
            case .unknown:
                return Image(systemName: "questionmark")
            }
        case .unknown:
            return Image(systemName: "questionmark")
        }
    }

    static func backgroundImg(forecasts: [Forecast]) -> Image {
        guard let current = Self.current(forecasts: forecasts) else {
            return Image("cloudy")
        }
        switch current.precipitationType {
        case .rain, .shower:
            return Image("rain")
        case .snow:
            return Image("snow")
        case .sleet:
            return Image("sleet")
        case .none:
            switch current.cloud {
            case .clear:
                return Image("clear")
            case .cloudy:
                return Image("cloudy")
            case .overcast:
                return Image("overcast")
            case .unknown:
                return Image(systemName: "questionmark")
            }
        case .unknown:
            return Image("cloudy")
        }
    }

}
