//
//  CityCard.swift
//  Weather
//
//  Created by 이상수 on 5/29/25.
//

import SwiftUI

struct CityCard: View {

    let weatherReport: WeatherReport

    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 5) {
                address
                skyIcon
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 5) {
                temperature
                uv
                airPollution
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.gray.opacity(0.3))
        )
    }

    private var address: some View {
        Text(weatherReport.address)
            .font(.title2)
    }

    private var skyIcon: some View {
        WeatherFormatter.current(forecasts: weatherReport.forecasts)?.skyImage
            .font(.subheadline)
    }

    private var temperature: some View {
        Text("\(WeatherFormatter.current(forecasts: weatherReport.forecasts)?.temperature ?? .zero)°")
            .font(.largeTitle)
            .fontWeight(.semibold)
    }

    private var uv: some View {
        Text("자외선: \(WeatherFormatter.uvLevel(for: weatherReport.uvIndex))")
            .font(.caption)
            .foregroundColor(.gray)
    }

    private var airPollution: some View {
        Text("대기: \(WeatherFormatter.pollutionLevel(for: weatherReport.airPollution))")
            .font(.caption)
            .foregroundColor(.gray)
    }

}
