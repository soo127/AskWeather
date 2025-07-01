//
//  WeatherView.swift
//  Weather
//
//  Created by 이상수 on 5/27/25.
//

import SwiftUI
import CoreLocation

struct WeatherView: View {

    @ObservedObject var viewModel: WeatherViewModel

    var body: some View {
        NavigationStack {
            weatherScreen
        }
        .environmentObject(viewModel)
        .toolbarBackground(.hidden)
    }

    private var weatherScreen: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("날씨 정보를 불러오는 중...")
            } else {
                contents
                    .foregroundStyle(.black)
            }
        }
    }

    private var contents: some View {
        ScrollView {
            TitleView()
                .foregroundStyle(.white)
            Text("\(viewModel.weatherReport.updatedAt)")
            HourlyForecastContainer()
            DailyForecastContainer()
            cardView
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal)
        .background(backgroundImage)
    }

    private var cardView: some View {
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

    private var backgroundImage: some View {
        ForecastProcessor.backgroundImg(forecasts: viewModel.forecasts)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }

}
