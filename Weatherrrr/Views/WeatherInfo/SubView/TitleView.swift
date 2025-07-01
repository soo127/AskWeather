//
//  TitleView.swift
//  Weather
//
//  Created by 이상수 on 6/5/25.
//

import SwiftUI

struct TitleView: View {

    @EnvironmentObject private var viewModel : WeatherViewModel

    var body: some View {
        VStack(spacing: 5) {
            address
            temperature
            dailyTemp
        }
        .padding(.vertical)
    }

    private var address: some View {
        Text(viewModel.address)
            .font(.title2)
    }

    private var temperature: some View {
        Text("\(viewModel.temperature)°")
            .font(.largeTitle)
    }

    private var dailyTemp: some View {
        HStack {
            Text("최고: \(viewModel.dailyHighTemp(after: 0), specifier: "%.0f")° ")
            Text("최저: \(viewModel.dailyLowTemp(after: 0), specifier: "%.0f")° ")
        }
    }

}
