//
//  WeatherView.swift
//  Weather
//
//  Created by 이상수 on 5/27/25.
//

import SwiftUI

struct WeatherView: View {

    @EnvironmentObject private var weatherViewModel : WeatherViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                content
                    .padding(.horizontal)
            }
            .background(Image("cloudy"))
            .scrollIndicators(.hidden)
        }
        .toolbarBackground(.hidden)
    }

    @ViewBuilder
    private var content: some View {
        TitleView()
        HourlyForecastView()
        DailyForecastView()

        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]) {
            WeatherCard { AirPollutionView() }
            WeatherCard { UltraVioletView() }
            WeatherCard { WindView() }
            WeatherCard { AirDiffusionView() }
            WeatherCard { PrecipitationView() }
            WeatherCard { HumidityView() }
        }
    }

}

#Preview {
    WeatherView()
        .environmentObject(WeatherViewModel())
}
