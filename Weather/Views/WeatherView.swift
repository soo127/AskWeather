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
                HourlyForecast()
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ]) {
                    WeatherCard { Wind() }
                    WeatherCard { Precipitation() }
                    WeatherCard { Humidity() }
                    WeatherCard { UltraViolet() }
                    WeatherCard { FineDust() }
                }
            }
            .padding(.horizontal)
        }

    }

}

#Preview {
    WeatherView()
}
