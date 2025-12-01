//
//  DailyForecastCell.swift
//  Weather
//
//  Created by 이상수 on 5/29/25.
//

import SwiftUI

struct DailyForecastCell: View {

    let dayOfWeek: String
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
        Text("\(dayOfWeek)")
            .frame(width: 50, alignment: .leading)
    }

    private var dailyTemp: some View {
        Group {
            Text(String(format: "%.0f", low) + "°")
                .foregroundStyle(.gray)
                .frame(width: 30, alignment: .trailing)
            capsule
            Text(String(format: "%.0f", high) + "°")
                .frame(width: 30, alignment: .trailing)
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
