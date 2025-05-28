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
                HourlyForecastView()
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ]) {
                    WeatherSection { WindView() }
                    WeatherSection { PrecipitationView() }
                    WeatherSection { HumidityView() }
                    WeatherSection { UVView() }
                    WeatherSection { FineDustView() }
                }
            }
            .padding(.horizontal)
        }

    }

}

#Preview {
    WeatherView()
}
