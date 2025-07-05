//
//  HumidityView.swift
//  Weather
//
//  Created by 이상수 on 5/28/25.
//

import SwiftUI

struct HumidityView: View {

    @EnvironmentObject private var viewModel : WeatherViewModel

    var body: some View {
        VStack(alignment: .leading) {
            title
            humidity
            Spacer()
            humidityAdvice
        }
        .padding()
    }

    private var title: some View {
        Text("습도")
            .font(.caption)
            .foregroundStyle(.gray)
    }

    private var humidity: some View {
        Text("\(viewModel.humidity)%")
            .font(.title2)
    }
    
    private var humidityAdvice: some View {
        Text(WeatherFormatter.humidityAdvice(for: viewModel.humidity))
            .font(.system(size: 13))
            .foregroundStyle(.black.opacity(0.7))
    }

}
