//
//  DailyForecast.swift
//  Weather
//
//  Created by 이상수 on 5/29/25.
//

import SwiftUI

struct DailyForecast: View {

    var body: some View {

        VStack(alignment: .leading) {
            title
            dailyForecasts
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.blue)
                .opacity(0.2)
        )

    }

    private var title: some View {
        Text("일간 일기 예보")
            .font(.caption)
            .foregroundStyle(.gray)
    }

    private var dailyForecasts: some View {
        Group {
            ForEach(1...4, id: \.self) { _ in
                DailyForecastItem()
            }
            .padding(.vertical, 5)
        }
    }

}

#Preview {
    DailyForecast()
}
