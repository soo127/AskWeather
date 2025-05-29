//
//  DailyForecastItem.swift
//  Weather
//
//  Created by 이상수 on 5/29/25.
//

import SwiftUI

struct DailyForecastItem: View {

    private let gradient = Gradient(colors: [
        .green, .yellow, .orange
    ])
    
    var body: some View {

        HStack {
            Text("오늘")
            Spacer()
            Image(systemName: "sun.max")
            Spacer()
            Text("13°")
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
            Text("25°")
        }

    }

}
