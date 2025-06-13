//
//  HumidityView.swift
//  Weather
//
//  Created by 이상수 on 5/28/25.
//

import SwiftUI

struct HumidityView: View {

    let weatherViewModel: WeatherViewModel

    var body: some View {
        VStack(alignment: .leading) {
            title
            humidity
        }
        .padding()
    }

    private var title: some View {
        Text("습도")
            .font(.caption)
            .foregroundStyle(.gray)
    }

    private var humidity: some View {
        Text("\(weatherViewModel.humidity ?? .zero, specifier: "%.1f")%")
            .font(.title2)
    }

}
