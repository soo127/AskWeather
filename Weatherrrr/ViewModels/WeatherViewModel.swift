//
//  KMAViewModel.swift
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
    private let now = Date()

    @MainActor
    func load(for coordinate: CLLocationCoordinate2D) async {
        do {
            let items = try await KMAAPI.fetchWeather(from: coordinate)
            self.forecasts = process(items: items)

            let (address, areaCode) = try await AddressAPI.fetch(from: coordinate)
            let nationalAir = try await AirPollutionAPI.fetch()
            airPollution = AirPollutionMapper.value(area: address, in: nationalAir)

            let uv = try await LifeWeatherIndexAPI.fetch(for: .uv, areaCode: areaCode)
            let air = try await LifeWeatherIndexAPI.fetch(for: .airDiffusion, areaCode: areaCode)
            uvIndex = uv?.current
            airDiffusionIndex = air?.after3Hours

        } catch {
            print("날씨 가져오기 실패: \(error)")
        }
    }

    private func process(items: [WeatherItem]) -> [Forecast] {
        var forecasts: [Date: Forecast] = [:]

        for item in items {
            guard let date = makeDate(from: item.fcstDate, time: item.fcstTime) else {
                continue
            }
            if forecasts[date] == nil {
                forecasts[date] = Forecast(dateTime: date)
            }
            if let keyPath = Forecast.categoryKeyPaths[item.category] {
                forecasts[date]![keyPath: keyPath] = item.fcstValue
            }
        }
        return forecasts.values.sorted(by: { $0.dateTime < $1.dateTime })
    }

    private func makeDate(from date: String, time: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmm"
        return formatter.date(from: date + time)
    }

}

// MARK: - 시간 단위 예보

extension WeatherViewModel {

    func todayHourlyInfo() -> [(time: String, sky: String, temp: String)] {
        let currentHour = truncatedHour
        let hourlyForecasts = todayForecasts(from: currentHour)
        return hourlyForecasts.map { formatForecast($0) }
    }

    private var truncatedHour: Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: now)
        return calendar.date(from: components)!
    }

    private func todayForecasts(from startDate: Date) -> ArraySlice<Forecast> {
        forecasts
            .filter { $0.dateTime >= startDate }
            .sorted { $0.dateTime < $1.dateTime }
            .prefix(24)
    }

    private func formatForecast(_ forecast: Forecast) -> (time: String, sky: String, temp: String) {
        let hour = Calendar.current.component(.hour, from: forecast.dateTime)
        let timeLabel = formatHourTo12H(hour: hour)
        let skyIcon = skyCodeToSymbol(code: forecast.skyCondition)
        return (time: timeLabel, sky: skyIcon, temp: forecast.temperature)
    }

    private func formatHourTo12H(hour: Int) -> String {
        switch hour {
        case 0: return "오전 12시"
        case 12: return "오후 12시"
        case 13..<24: return "오후 \(hour - 12)시"
        default: return "오전 \(hour)시"
        }
    }

    private func skyCodeToSymbol(code: String) -> String {
        switch code {
        case "1": return "sun.max"
        case "3": return "cloud.sun"
        case "4": return "cloud"
        default: return "questionmark"
        }
    }

}

// MARK: - 일간 예보

extension WeatherViewModel {

    func dailyLowTemp(afterdays offset: Int) -> Double? {
        let forecast = dailyTemp(onHour: 6, afterDays: offset)
        return Double(forecast?.dailyLowTemp ?? "")
    }

    func dailyHighTemp(afterdays offset: Int) -> Double? {
        let forecast = dailyTemp(onHour: 15, afterDays: offset)
        return Double(forecast?.dailyHighTemp ?? "")
    }

    private func dailyTemp(onHour hour: Int, afterDays offset: Int) -> Forecast? {
        guard let targetDate = Calendar.current.date(byAdding: .day, value: offset, to: now) else {
            return nil
        }
        let forecast = forecasts.first {
            Calendar.current.isDate($0.dateTime, inSameDayAs: targetDate) &&
            Calendar.current.component(.hour, from: $0.dateTime) == hour
        }
        return forecast
    }

    func dailySkyIcon(afterDays offset: Int) -> String? {
        guard let targetDate = Calendar.current.date(byAdding: .day, value: offset, to: now) else {
            return nil
        }
        let skyCodes = forecasts
            .filter {
                Calendar.current.isDate($0.dateTime, inSameDayAs: targetDate) &&
                (6...21).contains(Calendar.current.component(.hour, from: $0.dateTime))
            }
            .map { $0.skyCondition }

        if skyCodes.isEmpty {
            return nil
        }
        let clear = skyCodes.filter { $0 == "1" }.count
        let cloudy = skyCodes.filter { $0 == "3" }.count
        let overcast = skyCodes.filter { $0 == "4" }.count
        let total = clear + cloudy + overcast

        return (cloudy + overcast >= total / 3)
            ? (overcast > 0 ? "cloud" : "cloud.sun")
            : "sun.max"
    }

}

// MARK: - 그 외 섹션

extension WeatherViewModel {

    var currentForecast: Forecast? {
        forecasts.last(where: { $0.dateTime <= now })
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
        guard let value = uvIndex, let intValue = Int(value) else { return nil }
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
        guard let value = airDiffusionIndex, let intValue = Int(value) else { return nil }
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

    var humidity: Double? {
        Double(currentForecast?.humidity ?? "")
    }

    var temperature: Double? {
        Double(currentForecast?.temperature ?? "")
    }

    var windSpeed: Double? {
        Double(currentForecast?.windSpeed ?? "")
    }

    var rotateAngle: Double? {
        Double(currentForecast?.windVector ?? "")
    }

    func radian(angle: Double) -> Double {
        .pi * angle / 180
    }

    var averagePrecipitation: Double {
        let today = Calendar.current.startOfDay(for: now)
        let todayForecasts = forecasts.filter {
            Calendar.current.isDate($0.dateTime, inSameDayAs: today)
        }

        let values = todayForecasts.compactMap { forecast -> Double? in
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

        if values.isEmpty {
            return 0
        }
        return values.reduce(0, +) / Double(values.count)
    }

}
