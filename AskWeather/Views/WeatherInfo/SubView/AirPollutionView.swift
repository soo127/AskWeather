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
            GaugeBar(value: viewModel.airPollution, start: 0, end: 150)
        }
    }
    
    private var pollutionAdvice: some View {
        Text(WeatherFormatter.pollutionAdvice(for: viewModel.airPollution))
            .font(.system(size: 13))
            .foregroundStyle(.black.opacity(0.7))
    }

}
