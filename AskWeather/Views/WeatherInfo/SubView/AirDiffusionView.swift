//
//  AirStagnationView.swift
//  Weather
//
//  Created by 이상수 on 5/29/25.
//

import SwiftUI

struct AirDiffusionView: View {

    @EnvironmentObject private var viewModel : WeatherViewModel

    var body: some View {
        VStack(alignment: .leading) {
            title
            diffusionLevel
            Spacer()
            diffusionAdvice
        }
        .padding()
    }

    private var title: some View {
        Text("대기정체지수 (이후 3시간)")
            .font(.caption)
            .foregroundStyle(.gray)
    }

    private var diffusionLevel: some View {
        Group {
            Text("\(viewModel.airDiffusionIndex)")
                .font(.title)
            Text(viewModel.airDiffusionLevel)
                .font(.title2)
            GaugeBar(value: viewModel.airDiffusionIndex, start: 0, end: 100)
        }
    }
    
    private var diffusionAdvice: some View {
        Text(WeatherFormatter.airDiffusionAdvice(for: viewModel.airDiffusionIndex))
            .font(.system(size: 13))
            .foregroundStyle(.black.opacity(0.7))
    }

    

}
