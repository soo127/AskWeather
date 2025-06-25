//
//  CityCard.swift
//  Weather
//
//  Created by 이상수 on 5/29/25.
//

import SwiftUI

struct CityCard: View {

    let report: WeatherReport

    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 5) {
                address
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
