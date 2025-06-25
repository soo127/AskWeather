//
//  CityCard.swift
//  Weather
//
//  Created by 이상수 on 5/29/25.
//

import SwiftUI

struct CityCard: View {

    @EnvironmentObject private var weatherStorage: WeatherStorage
    @State private var isChecked = false
    let report: WeatherReport

    var body: some View {
        HStack(alignment: .center) {
            if weatherStorage.isEditMode {
                checkButton
            }
            card
        }
    }

    private var checkButton: some View {
        Button {
            isChecked.toggle()
            weatherStorage.toggleFavorite(report: report)
        } label: {
            Image(systemName: isChecked ? "checkmark.circle" : "circle")
                .resizable()
                .frame(width: 20, height: 20)
        }
    }

    private var card: some View {
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
        .padding()
        .foregroundStyle(.white)
        .background(backgroundImage)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .contentShape(RoundedRectangle(cornerRadius: 12))
    }

    private var address: some View {
        Text(report.address)
            .font(.title2)
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
