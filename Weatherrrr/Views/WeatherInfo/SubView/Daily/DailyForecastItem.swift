//
//  DailyForecastItem.swift
//  Weather
//
//  Created by 이상수 on 5/29/25.
//

import SwiftUI

struct DailyForecastItem: View {

    let afterDays: Int
    let skyIcon: String
    let high: Double
    let low: Double

    var body: some View {
        HStack {
            Text("\(afterDays == 0 ? "오늘" : "\(afterDays)일 뒤")")
                .frame(width: 50, alignment: .leading)
            Spacer()

            Image(systemName: skyIcon)
            Spacer()

            Text(String(format: "%.0f", low) + "°")
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

            Text(String(format: "%.0f", high) + "°")
        }
    }

    private let gradient = Gradient(colors: [
        .green, .yellow, .orange
    ])

}
