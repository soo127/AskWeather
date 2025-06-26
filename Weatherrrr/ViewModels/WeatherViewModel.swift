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

    init(coordinate: CLLocationCoordinate2D?, address: String?) {
        load(coordinate: coordinate, address: address)
    }

    /// using cache
    init(report: WeatherReport) {
        if report.updatedAt.isSameHour(comparedTo: now) { // can use cache
            self.weatherReport = report
            isLoading = false
            return
        }
        load(coordinate: report.coordinate)
    }

    private func load(coordinate: CLLocationCoordinate2D?, address: String? = nil) {
        Task { @MainActor in
            do {
                weatherReport = try await WeatherLoader.load(coordinate: coordinate, displayAddress: address)
            } catch {
                print("날씨 로딩 실패: \(error)")
            }
            isLoading = false
        }
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

    func dailyLowTemp(after: Int) -> Double {
        ForecastProcessor.dailyTemp(forecasts: forecasts, type: .low, after: after) ?? .zero
    }

    func dailyHighTemp(after: Int) -> Double {
        ForecastProcessor.dailyTemp(forecasts: forecasts, type: .high, after: after) ?? .zero
    }

    func dailySkyIcon(after: Int) -> Image {
        ForecastProcessor.dailySkyIcon(forecasts: forecasts, after: after)
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
        ForecastProcessor.current(forecasts: forecasts)?.humidity ?? .zero
    }

    var temperature: Int {
        ForecastProcessor.current(forecasts: forecasts)?.temperature ?? .zero
    }

    var windSpeed: Double {
        ForecastProcessor.current(forecasts: forecasts)?.windSpeed ?? .zero
    }

    var rotateAngle: Int {
        ForecastProcessor.current(forecasts: forecasts)?.windVector ?? .zero
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
