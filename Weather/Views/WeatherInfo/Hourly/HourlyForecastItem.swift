//
//  HourlyForecastItem.swift
//  Weather
//
//  Created by 이상수 on 5/27/25.
//

import SwiftUI

struct HourlyForecastItem: View {

    let time: Int
    let iconName: String
    let temperature: Int

    var body: some View {

        VStack(spacing: 5) {
            Text("오전 \(time)시")
            Image(systemName: iconName)
            Text("\(temperature)°")
        }
        .padding(.horizontal, 5)

    }

}
