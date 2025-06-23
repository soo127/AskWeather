//
//  TitleView.swift
//  Weather
//
//  Created by 이상수 on 6/5/25.
//

import SwiftUI

struct TitleView: View {

    @EnvironmentObject private var weatherViewModel : WeatherViewModel

    var body: some View {
        VStack(spacing: 5) {
            address
            temperature
            dailyTemp
        }
        .padding(.vertical)
    }

    private var address: some View {
        Text(weatherViewModel.address)
            .font(.title2)
    }

    private var temperature: some View {
        Text("\(weatherViewModel.temperature)°")
            .font(.largeTitle)
    }

    private var dailyTemp: some View {
        HStack {
            Text("최고: \(weatherViewModel.dailyHighTemp(afterdays: 0), specifier: "%.0f")° ")
            Text("최저: \(weatherViewModel.dailyLowTemp(afterdays: 0), specifier: "%.0f")° ")
        }
    }

}
