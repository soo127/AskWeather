//
//  WeatherView.swift
//  Weather
//
//  Created by 이상수 on 5/27/25.
//

import SwiftUI

struct WeatherView: View {

    @EnvironmentObject var locationManager: LocationManager

    var body: some View {

        NavigationStack {

            ScrollView {
                title
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


    private var title: some View {
        VStack(spacing: 5) {
            if let userLocation = locationManager.userLocation {
                Text("경도: \(userLocation.longitude), 위도: \(userLocation.latitude)")
            }
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
        .environmentObject(LocationManager())
}
