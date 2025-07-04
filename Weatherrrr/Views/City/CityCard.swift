//
//  CityCard.swift
//  Weather
//
//  Created by 이상수 on 5/29/25.
//

import SwiftUI

struct CityCard: View {

    @EnvironmentObject private var weatherStorage: WeatherStorage
    let report: WeatherReport

    var body: some View {
        contents
            .padding()
            .foregroundStyle(.white)
            .background(backgroundImage)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .contentShape(RoundedRectangle(cornerRadius: 12))
    }

    private var contents: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 5) {
                address
                dailyTemp
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 5) {
                temperature
                uv
                airPollution
            }
        }
    }

    private var address: some View {
        Text(report.address)
            .font(.title2)
            .fontWeight(.semibold)
    }

    private var dailyTemp: some View {
        Group {
            Text("최고: \(ForecastProcessor.dailyTemp(forecasts: report.forecasts, type: .high) ?? .zero, specifier: "%.0f")°")
            Text("최저: \(ForecastProcessor.dailyTemp(forecasts: report.forecasts, type: .low) ?? .zero, specifier: "%.0f")°")
        }
        .font(.caption2)
    }

    private var temperature: some View {
        Text("\(ForecastProcessor.current(forecasts: report.forecasts)?.temperature ?? .zero)°")
            .font(.largeTitle)
            .fontWeight(.semibold)
    }

    private var uv: some View {
        Text("자외선: \(WeatherFormatter.uvLevel(for: report.uvIndex))")
            .font(.caption)
    }

    private var airPollution: some View {
        Text("대기: \(WeatherFormatter.pollutionLevel(for: report.airPollution))")
            .font(.caption)
    }

    private var backgroundImage: some View {
        ForecastProcessor.backgroundImg(forecasts: report.forecasts)
            .resizable()
            .scaledToFill()
    }

}
