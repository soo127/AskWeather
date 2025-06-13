//
//  AirPollutionView.swift
//  Weather
//
//  Created by 이상수 on 5/28/25.
//

import SwiftUI

struct AirPollutionView: View {

    let weatherViewModel: WeatherViewModel

    var body: some View {
        VStack(alignment: .leading) {
            title
            dustLevel
        }
        .padding()
    }

    private let gradient = Gradient(colors: [
        .blue, .green, .yellow, .orange, .red, .brown
    ])

    private var title: some View {
        Text("미세먼지 농도 (㎍/㎥)")
            .font(.caption)
            .foregroundStyle(.gray)
    }

    private var dustLevel: some View {
        Group {
            Text(weatherViewModel.airPollution ?? "0")
                .font(.title)
            Text(weatherViewModel.pollutionLevel ?? "0")
                .font(.title2)
            Capsule()
                .frame(width: 150, height: 5)
                .overlay(
                    LinearGradient(
                        gradient: gradient,
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
        }
    }

}
