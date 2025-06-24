//
//  DailyForecastCell.swift
//  Weather
//
//  Created by 이상수 on 5/29/25.
//

import SwiftUI

struct DailyForecastCell: View {

    let afterDays: Int
    let skyIcon: Image
    let high: Double
    let low: Double

    var body: some View {
        HStack {
            date
            Spacer()
            skyIcon
            Spacer()
            dailyTemp
        }
    }

    private var date: some View {
        Text("\(afterDays == 0 ? "오늘" : "\(afterDays)일 뒤")")
            .frame(width: 50, alignment: .leading)
    }

    private var dailyTemp: some View {
        Group {
            Text(String(format: "%.0f", low) + "°")
                .foregroundStyle(.gray)
            capsule
            Text(String(format: "%.0f", high) + "°")
        }
    }

    private var capsule: some View {
        Capsule()
            .frame(width: 100, height: 5)
            .overlay(
                LinearGradient(
                    gradient: gradient,
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
    }

    private let gradient = Gradient(colors: [
        .green, .yellow, .orange
    ])

}
