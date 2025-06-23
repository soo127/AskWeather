//
//  WeatherViewModel.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/9/25.
//

import SwiftUI
import CoreLocation

class WeatherViewModel: ObservableObject {

    @Published var weatherReport: WeatherReport = .empty
    @Published var isLoading = true
    private let now = Date()

    init(coordinate: CLLocationCoordinate2D?) {
        Task {
            await load(coordinate: coordinate)
        }
    }

    @MainActor
    func load(coordinate: CLLocationCoordinate2D?) async {
        do {
            weatherReport = try await WeatherLoader.load(coordinate: coordinate)
        } catch {
            print("날씨 로딩 실패: \(error)")
        }
        isLoading = false
    }

}

// MARK: - 편리한 접근

extension WeatherViewModel {

    var forecasts: [Forecast] {
        weatherReport.forecasts
    }

    var address: String {
        weatherReport.address
    }

    var areaCode: String {
        weatherReport.areaCode
    }

    var coordinate: CLLocationCoordinate2D {
        weatherReport.coordinate
    }

    var uvIndex: Int {
        weatherReport.uvIndex
    }

    var airPollution: Int {
        weatherReport.airPollution
    }

    var airDiffusionIndex: Int {
        weatherReport.airDiffusionIndex
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
                Calendar.current.isDate($0.date, inSameDayAs: targetDate)
            }
            .map { $0.cloud }

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

    var pollutionLevel: String {
        WeatherFormatter.pollutionLevel(for: airPollution)
    }

    var uvLevel: String {
        WeatherFormatter.uvLevel(for: uvIndex)
    }

    var airDiffusionLevel: String {
        WeatherFormatter.airDiffusionLevel(for: airDiffusionIndex)
    }

    var humidity: Int {
        WeatherFormatter.current(forecasts: forecasts)?.humidity ?? .zero
    }

    var temperature: Int {
        WeatherFormatter.current(forecasts: forecasts)?.temperature ?? .zero
    }

    var windSpeed: Double {
        WeatherFormatter.current(forecasts: forecasts)?.windSpeed ?? .zero
    }

    var rotateAngle: Int {
        WeatherFormatter.current(forecasts: forecasts)?.windVector ?? .zero
    }

    func radian(angle: Double) -> Double {
        .pi * angle / 180
    }

    var averagePrecipitation: Double {
        let today = Calendar.current.startOfDay(for: now)
        let todayForecasts = forecasts.filter {
            Calendar.current.isDate($0.date, inSameDayAs: today)
        }

        let values = todayForecasts.map(\.parcipitation)
        guard !values.isEmpty else { return 0 }
        return values.reduce(0, +) / Double(values.count)
    }

}
