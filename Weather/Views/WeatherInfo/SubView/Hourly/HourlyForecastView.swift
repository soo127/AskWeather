//
//  HourlyForecastView.swift
//  Weather
//
//  Created by 이상수 on 5/27/25.
//

import SwiftUI

struct HourlyForecastView: View {

    @EnvironmentObject private var weatherManager: WeatherManager

    var body: some View {

        VStack(alignment: .leading) {
            title
            hourlyForecasts
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .opacity(0.8)
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
                let (time,sky,temp) = weatherManager.getHourlyInfo(during: 24)

                ForEach(0...23, id: \.self) { index in
                    HourlyForecastItem(time: time[index], iconName: sky[index], temperature: temp[index])
                }
            }
        }
    }

}

#Preview {
    HourlyForecastView()
        .environmentObject(WeatherManager())
}
