//
//  AirStagnationView.swift
//  Weather
//
//  Created by 이상수 on 5/29/25.
//

import SwiftUI

struct AirDiffusionView: View {

    let weatherViewModel: WeatherViewModel

    var body: some View {
        VStack(alignment: .leading) {
            title
            diffusionLevel
        }
        .padding()
    }

    private let gradient = Gradient(colors: [
        .blue, .green, .yellow, .orange, .red, .brown
    ])

    private var title: some View {
        Text("대기 정체 지수 (이후 3시간)")
            .font(.caption)
            .foregroundStyle(.gray)
    }

    private var diffusionLevel: some View {
        Group {
            Text(weatherViewModel.airDiffusionIndex ?? "0")
                .font(.title)
            Text(weatherViewModel.airIndexLevel ?? "0")
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
