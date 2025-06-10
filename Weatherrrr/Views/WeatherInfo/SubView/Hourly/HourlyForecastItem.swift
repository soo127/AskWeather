//
//  HourlyForecastItem.swift
//  Weather
//
//  Created by 이상수 on 5/27/25.
//

import SwiftUI

struct HourlyForecastItem: View {

    let time: String
    let iconName: String
    let temperature: String

    var body: some View {
        VStack(spacing: 5) {
            Text(time)
            Image(systemName: iconName)
            Text("\(Double(temperature) ?? .zero, specifier: "%.0f")°")
        }
        .padding(.horizontal, 5)
    }

}
