//
//  KMAViewModel.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/9/25.
//

import SwiftUI
import CoreLocation

class KMAViewModel: ObservableObject {

    @Published var forecasts: [Forecast] = []

    func loadWeather(for coordinate: CLLocationCoordinate2D) async {
        do {
            let items = try await KMAAPI.fetchWeather(from: coordinate)
            self.forecasts = process(items: items)
            print(forecasts)
        } catch {
            print("날씨 가져오기 실패: \(error)")
        }
    }

    private func process(items: [KMAItem]) -> [Forecast] {
        var forecasts: [Date: Forecast] = [:]

        for item in items {
            guard let date = makeDate(from: item.fcstDate, time: item.fcstTime) else {
                continue
            }
            if forecasts[date] == nil {
                forecasts[date] = Forecast(dateTime: date)
            }

            switch item.category {
            case "PCP":
                forecasts[date]!.parcipitation = item.fcstValue
            case "REH":
                forecasts[date]!.humidity = item.fcstValue
            case "TMX":
                forecasts[date]!.dailyHighTemp = item.fcstValue
            case "TMN":
                forecasts[date]!.dailyLowTemp = item.fcstValue
            case "TMP":
                forecasts[date]!.temperature = item.fcstValue
            case "VEC":
                forecasts[date]!.windVector = item.fcstValue
            case "WSD":
                forecasts[date]!.windSpeed = item.fcstValue
            case "SKY":
                forecasts[date]!.skyCondition = item.fcstValue
            default:
                continue
            }
        }
        return forecasts.values.sorted(by: { $0.dateTime < $1.dateTime } )
    }

    private func makeDate(from date: String, time: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmm"
        return formatter.date(from: date + time)
    }

    var currentForecast: Forecast? {
        return forecasts.last(where: { $0.dateTime <= Date() })
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
        let today = Calendar.current.startOfDay(for: Date())
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

    func hourlyInfo(forNext hours: Int) -> [(time: String, sky: String, temp: String)] {
        let now = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: now)
        let currentHour = calendar.date(from: components)!

        let hourlyForecasts = forecasts
            .filter { $0.dateTime >= currentHour }
            .sorted { $0.dateTime < $1.dateTime }
            .prefix(hours)

        return hourlyForecasts.map { forecast in
            let hour = calendar.component(.hour, from: forecast.dateTime)
            let timeLabel = timeLabel(hour: hour)
            let sky = mapSkyCode(forecast.skyCondition)
            let temp = forecast.temperature
            return (time: timeLabel, sky: sky, temp: temp)
        }
    }

    private func timeLabel(hour: Int) -> String {
        if hour == 0 {
            return "오전 12시"
        } else if hour == 12 {
            return "오후 12시"
        } else if hour > 12 {
            return "오후 \(hour - 12)시"
        } else {
            return "오전 \(hour)시"
        }
    }

    private func mapSkyCode(_ code: String) -> String {
        switch code {
        case "1": return "sun.max"
        case "3": return "cloud.sun"
        case "4": return "cloud"
        default: return "questionmark"
        }
    }

    func dailyLowTemp(afterdays offset: Int) -> Double? {
        let forecast = dailyTemp(onHour: 6, afterDays: offset)
        return Double(forecast?.dailyLowTemp ?? "")
    }

    func dailyHighTemp(afterdays offset: Int) -> Double? {
        let forecast = dailyTemp(onHour: 15, afterDays: offset)
        return Double(forecast?.dailyHighTemp ?? "")
    }

    private func dailyTemp(onHour hour: Int, afterDays offset: Int) -> Forecast? {
        guard let targetDate = Calendar.current.date(byAdding: .day, value: offset, to: Date()) else {
            return nil
        }
        let forecast = forecasts.first {
            Calendar.current.isDate($0.dateTime, inSameDayAs: targetDate) &&
            Calendar.current.component(.hour, from: $0.dateTime) == hour
        }
        return forecast
    }

    func dailySkyIcon(afterDays offset: Int) -> String? {
        guard let targetDate = Calendar.current.date(byAdding: .day, value: offset, to: Date()) else {
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
