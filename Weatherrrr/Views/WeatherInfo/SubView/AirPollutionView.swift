//
//  AirPollutionView.swift
//  Weather
//
//  Created by 이상수 on 5/28/25.
//

import SwiftUI

struct AirPollutionView: View {

    @EnvironmentObject private var viewModel : WeatherViewModel

    var body: some View {
        VStack(alignment: .leading) {
            title
            pollutionLevel
            Spacer()
            pollutionAdvice
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

    private var pollutionLevel: some View {
        Group {
            Text("\(viewModel.airPollution)")
                .font(.title)
            Text("\(viewModel.pollutionLevel)")
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
    
    private var pollutionAdvice: some View {
        Text(WeatherFormatter.pollutionAdvice(for: viewModel.airPollution))
            .font(.system(size: 13))
            .foregroundStyle(.black.opacity(0.7))
    }

}
