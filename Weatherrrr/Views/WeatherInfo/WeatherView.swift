//
//  WeatherView.swift
//  Weather
//
//  Created by 이상수 on 5/27/25.
//

import SwiftUI

struct WeatherView: View {

    @EnvironmentObject private var mainViewModel : MainViewModel

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
        let kma = mainViewModel.weatherViewModel
        let addr = mainViewModel.addressManager

        TitleView(weatherViewModel: kma, addressManager: addr)
        HourlyForecastView(weatherViewModel: kma)
        DailyForecastView(weatherViewModel: kma)

        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]) {
            WeatherCard { AirPollutionView(weatherViewModel: kma) }
            WeatherCard { UltraVioletView(weatherViewModel: kma) }
            WeatherCard { WindView(weatherViewModel: kma) }
            WeatherCard { AirDiffusionView(weatherViewModel: kma) }
            WeatherCard { PrecipitationView(weatherViewModel: kma) }
            WeatherCard { HumidityView(weatherViewModel: kma) }
        }
    }

}

#Preview {
    WeatherView()
        .environmentObject(MainViewModel())
}
