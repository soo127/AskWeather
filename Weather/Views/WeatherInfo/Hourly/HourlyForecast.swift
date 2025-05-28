//
//  HourlyForecast.swift
//  Weather
//
//  Created by 이상수 on 5/27/25.
//

import SwiftUI

struct HourlyForecast: View {

    var body: some View {

        VStack(alignment: .leading) {
            title
            hourlyForecasts
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.blue)
                .opacity(0.2)
        )

    }

    private var title: some View {
        Text("시간별 일기예보")
            .font(.caption)
            .foregroundStyle(.gray)
    }

    private var hourlyForecasts: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack {
                ForEach(1...15, id: \.self) { index in
                    HourlyForecastItem(time: index, iconName: "sun.max", temperature: 30-index)
                }
            }
        }
    }

}

#Preview {
    HourlyForecast()
}
