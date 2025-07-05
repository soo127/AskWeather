//
//  UltraVioletView.swift
//  Weather
//
//  Created by 이상수 on 5/28/25.
//

import SwiftUI

struct UltraVioletView: View {

    @EnvironmentObject private var viewModel : WeatherViewModel

    var body: some View {
        VStack(alignment: .leading) {
            title
            uvLevel
            Spacer()
            uvAdvice
        }
        .padding()
    }

    private var title: some View {
        Text("자외선 지수")
            .font(.caption)
            .foregroundStyle(.gray)
    }

    private var uvLevel: some View {
        Group {
            Text("\(viewModel.uvIndex)")
                .font(.title)
            Text(viewModel.uvLevel)
                .font(.title2)
            GaugeBar(value: viewModel.uvIndex, start: 0, end: 11)
        }
    }
    
    private var uvAdvice: some View {
        Text(WeatherFormatter.uvAdvice(for: viewModel.uvIndex))
            .font(.system(size: 13))
            .foregroundStyle(.black.opacity(0.7))
    }

}
