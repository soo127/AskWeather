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
                TitleView()
                HourlyForecastView()
                DailyForecastView()

                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ]) {
                    WeatherCard { FineDustView() }
                    WeatherCard { UltraVioletView() }
                    WeatherCard { WindView() }
                    WeatherCard { AirStagnationView() }
                    WeatherCard { PrecipitationView() }
                    WeatherCard { HumidityView() }
                }
            }
            .background(Image("cloudy"))
            .scrollIndicators(.hidden)
            .padding(.horizontal)
        }
        .toolbarBackground(.hidden)

    }

}

#Preview {
    WeatherView()
        .environmentObject(LocationManager())
        .environmentObject(WeatherManager())
        .environmentObject(AddressManager())
}
