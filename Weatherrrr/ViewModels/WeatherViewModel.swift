//
//  WeatherViewModel.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/9/25.
//

import SwiftUI
import CoreLocation

class WeatherViewModel: ObservableObject {

    @Published var forecasts: [Forecast] = []
    @Published var uvIndex: String?
    @Published var airDiffusionIndex: String?
    @Published var airPollution: String?
    @Published var address: String?
    @Published var areaCode: String?

    private let now = Date()

    @MainActor
    func load(coordinate: CLLocationCoordinate2D) async {
        do {
            let (address, areaCode) = try await AddressAPI.fetch(from: coordinate)
            self.address = address
            self.areaCode = areaCode

            async let nationalAir = AirPollutionAPI.fetch()
            async let uv = LifeWeatherIndexAPI.fetch(index: .uv, areaCode: areaCode)
            async let air = LifeWeatherIndexAPI.fetch(index: .airDiffusion, areaCode: areaCode)
            async let items = KMAAPI.fetch(coordinate: coordinate)

            airPollution = AirPollutionMapper.value(area: address, in: try await nationalAir)
            uvIndex = try await uv?.current
            airDiffusionIndex = try await air?.after3Hours
            forecasts = makeForecasts(items: try await items)
        } catch {
            print("날씨 가져오기 실패: \(error)")
        }
    }

    private func makeForecasts(items: [KMAAPI.Item]) -> [Forecast] {
        let itemsByDate: [Date: [KMAAPI.Item]] = items
            .reduce(into: [:]) { partialResult, item in
                let dateString = item.fcstDate + item.fcstTime
                guard let date = dateString.date() else {
                    return
                }
                let prevItems = partialResult[date] ?? []
                return partialResult[date] = (prevItems + [item])
            }

        let forecasts = itemsByDate
            .sorted { $0.key < $1.key }
            .map { (date, items) in
                var forecast = Forecast(date: date)
                forecast.update(items: items)
                return forecast
            }

        return forecasts
    }

}

// MARK: - 시간 단위 예보

extension WeatherViewModel {

    func todayHourlyViewModels() -> [HourlyForecastCell.ViewModel] {
        let currentHour = truncatedHour
        let hourlyForecasts = todayForecasts(from: currentHour)
        return hourlyForecasts.map { .init(forecast: $0) }
    }

    private var truncatedHour: Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: now)
        return calendar.date(from: components)!
    }

    private func todayForecasts(from startDate: Date) -> ArraySlice<Forecast> {
        forecasts
            .filter { $0.date >= startDate }
            .sorted { $0.date < $1.date }
            .prefix(24)
    }

}

// MARK: - 일간 예보

extension WeatherViewModel {

    func dailyLowTemp(afterdays offset: Int) -> Double {
        let forecast = dailyTemp(onHour: 6, afterDays: offset)
        return forecast?.dailyLowTemp ?? .zero
    }

    func dailyHighTemp(afterdays offset: Int) -> Double {
        let forecast = dailyTemp(onHour: 15, afterDays: offset)
        return forecast?.dailyHighTemp ?? .zero
    }

    private func dailyTemp(onHour hour: Int, afterDays offset: Int) -> Forecast? {
        guard let targetDate = Calendar.current.date(byAdding: .day, value: offset, to: now) else {
            return nil
        }
        let forecast = forecasts.first {
            Calendar.current.isDate($0.date, inSameDayAs: targetDate) &&
            Calendar.current.component(.hour, from: $0.date) == hour
        }
        return forecast
    }

    func dailySkyIcon(afterDays offset: Int) -> String {
        guard let targetDate = Calendar.current.date(byAdding: .day, value: offset, to: now) else {
            return "questionmark"
        }
        let skyCodes = forecasts
            .filter {
                Calendar.current.isDate($0.date, inSameDayAs: targetDate) &&
                (6...21).contains(Calendar.current.component(.hour, from: $0.date))
            }
            .map { $0.skyCondition }

        if skyCodes.isEmpty {
            return "questionmark"
        }
        let clear = skyCodes.filter { $0 == .clear }.count
        let cloudy = skyCodes.filter { $0 == .cloudy }.count
        let overcast = skyCodes.filter { $0 == .overcast }.count
        let total = clear + cloudy + overcast

        return (cloudy + overcast >= total / 3)
            ? (overcast > 0 ? "cloud" : "cloud.sun")
            : "sun.max"
    }

}

// MARK: - 그 외 섹션

extension WeatherViewModel {

    var currentForecast: Forecast? {
        forecasts.last(where: { $0.date <= now })
    }

    var pollutionLevel: String? {
        guard let airPollution = airPollution,
              let amount = Int(airPollution) else {
            return nil
        }
        switch amount {
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

    var uvIndexLevel: String? {
        guard let value = uvIndex,
              let intValue = Int(value) else {
            return nil
        }
        switch intValue {
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

    var airIndexLevel: String? {
        guard let value = airDiffusionIndex,
              let intValue = Int(value) else {
            return nil
        }
        switch intValue {
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

    var humidity: Int {
        currentForecast?.humidity ?? .zero
    }

    var temperature: Int {
        currentForecast?.temperature ?? .zero
    }

    var windSpeed: Double {
        currentForecast?.windSpeed ?? .zero
    }

    var rotateAngle: Int {
        currentForecast?.windVector ?? .zero
    }

    func radian(angle: Double) -> Double {
        .pi * angle / 180
    }

    var averagePrecipitation: Double {
        let today = Calendar.current.startOfDay(for: now)
        let todayForecasts = forecasts.filter {
            Calendar.current.isDate($0.date, inSameDayAs: today)
        }
        let values = todayForecasts.compactMap { forecast -> Double? in
            print(forecast.parcipitation)
            switch forecast.parcipitation {
            case "강수없음":
                return 0
            case "1mm 미만":
                return 0.05
            case "30":
                return 40.0
            case "50":
                return 60.0
            default:
                return Double(forecast.parcipitation)
            }
        }
        print(values)
        if values.isEmpty {
            return 0
        }
        print(values.reduce(0, +))
        print(Double(values.count))
        //print(values.reduce(0, +) / Double(values.count))
        return values.reduce(0, +) / Double(values.count)
    }

}
