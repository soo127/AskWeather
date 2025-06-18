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
            Text(weatherViewModel.address)
                .font(.title2)
            Text("\(weatherViewModel.temperature)°")
                .font(.largeTitle)
            HStack {
                Text("최고: \(weatherViewModel.dailyHighTemp(afterdays: 0), specifier: "%.0f")° ")
                Text("최저: \(weatherViewModel.dailyLowTemp(afterdays: 0), specifier: "%.0f")° ")
            }
        }
        .padding(.vertical)
    }

}
