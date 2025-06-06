//
//  PrecipitationView.swift
//  Weather
//
//  Created by 이상수 on 5/27/25.
//

import SwiftUI

struct PrecipitationView: View {

    @EnvironmentObject private var weatherManager: WeatherManager

    var body: some View {

        VStack(alignment: .leading) {
            title
            precipitation
        }
        .padding()
    }

    private var title: some View {
        Text("오늘 평균 강수량")
            .font(.caption)
            .foregroundStyle(.gray)
    }

    private var precipitation: some View {
        Text("\(weatherManager.averagePrecipitation, specifier: "%.1f")mm")
            .font(.title2)
    }

}
