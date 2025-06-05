//
//  HumidityView.swift
//  Weather
//
//  Created by 이상수 on 5/28/25.
//

import SwiftUI

struct HumidityView: View {

    @EnvironmentObject private var weatherManager: WeatherManager

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
        Text("\(weatherManager.humidity, specifier: "%.1f")%")
            .font(.title2)
    }

}
