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
        let kma = mainViewModel.kmaViewModel
        let addr = mainViewModel.addressManager

        TitleView(kmaViewModel: kma, addressManager: addr)
        HourlyForecastView(kmaViewModel: kma)
        DailyForecastView(kmaViewModel: kma)

        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]) {
            WeatherCard { FineDustView() }
            WeatherCard { UltraVioletView() }
            WeatherCard { WindView(kmaViewModel: mainViewModel.kmaViewModel) }
            WeatherCard { AirStagnationView() }
            WeatherCard { PrecipitationView(kmaViewModel: mainViewModel.kmaViewModel) }
            WeatherCard { HumidityView(kmaViewModel: mainViewModel.kmaViewModel) }
        }
    }

}

#Preview {
    WeatherView()
        .environmentObject(MainViewModel())
}
