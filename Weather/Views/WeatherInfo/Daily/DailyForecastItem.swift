//
//  DailyForecastItem.swift
//  Weather
//
//  Created by 이상수 on 5/29/25.
//

import SwiftUI

struct DailyForecastItem: View {

    @EnvironmentObject private var weatherManager: WeatherManager
    let later: Int

    var body: some View {

        HStack {
            Text("\(later == 0 ? "오늘" : "\(later)일 뒤")")
                .frame(width: 50, alignment: .leading)
            Spacer()
            Image(systemName: weatherManager.getDailySky(later))
            Spacer()
            Text(String(format: "%.0f", weatherManager.getLowestTemp(later: later)) + "°")
                .foregroundStyle(.gray)
            Capsule()
                .frame(width: 100, height: 5)
                .overlay(
                    LinearGradient(
                        gradient: gradient,
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    
                )
            Text(String(format: "%.0f", weatherManager.getHighestTemp(later: later)) + "°")
        }

    }

    private let gradient = Gradient(colors: [
        .green, .yellow, .orange
    ])

}
