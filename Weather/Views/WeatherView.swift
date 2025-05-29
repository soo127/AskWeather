//
//  WeatherView.swift
//  Weather
//
//  Created by 이상수 on 5/27/25.
//

import SwiftUI

struct WeatherView: View {

    var body: some View {

        NavigationStack {

            ScrollView {
                title
                HourlyForecast()
                DailyForecast()
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ]) {
                    WeatherCard { FineDust() }
                    WeatherCard { UltraViolet() }
                    WeatherCard { Wind() }
                    WeatherCard { AirStagnation() }
                    WeatherCard { Precipitation() }
                    WeatherCard { Humidity() }
                }
            }
            .background(Image("cloudy"))
            .padding(.horizontal)
        }
    }


    private var title: some View {
        VStack(spacing: 5) {
            Text("화성시")
                .font(.title)
            Text("23°")
                .font(.largeTitle)
            Text("최고: 25°, 최저: 21°")
        }
        .padding(.vertical)
    }

}

#Preview {
    WeatherView()
}
