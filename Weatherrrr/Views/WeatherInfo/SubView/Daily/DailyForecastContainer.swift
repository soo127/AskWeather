//
//  DailyForecastContainer.swift
//  Weather
//
//  Created by 이상수 on 5/29/25.
//

import SwiftUI

struct DailyForecastContainer: View {

    @EnvironmentObject private var weatherViewModel : WeatherViewModel

    var body: some View {
        VStack(alignment: .leading) {
            title
            dailyForecasts
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .opacity(0.8)
        )
    }

    private var title: some View {
        Text("일간 일기 예보")
            .font(.caption)
            .foregroundStyle(.gray)
    }

    private var dailyForecasts: some View {
        Group {
            ForEach(0...3, id: \.self) { day in
                DailyForecastCell(
                    afterDays: day,
                    skyIcon: weatherViewModel.dailySkyIcon(afterDays: day),
                    high: weatherViewModel.dailyHighTemp(afterdays: day),
                    low: weatherViewModel.dailyLowTemp(afterdays: day)
                )
            }
            .padding(.vertical, 5)
        }
    }

}

#Preview {
    DailyForecastContainer()
}
