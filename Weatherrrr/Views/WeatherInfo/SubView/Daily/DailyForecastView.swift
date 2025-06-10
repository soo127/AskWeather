//
//  DailyForecastView.swift
//  Weather
//
//  Created by 이상수 on 5/29/25.
//

import SwiftUI

struct DailyForecastView: View {

    let kmaViewModel: KMAViewModel

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
                DailyForecastItem(
                    afterDays: day,
                    skyIcon: kmaViewModel.dailySkyIcon(afterDays: day) ?? "questionmark",
                    high: kmaViewModel.dailyHighTemp(afterdays: day) ?? .zero,
                    low: kmaViewModel.dailyLowTemp(afterdays: day) ?? .zero
                )
            }
            .padding(.vertical, 5)
        }
    }

}

#Preview {
    DailyForecastView(kmaViewModel: .init())
}
