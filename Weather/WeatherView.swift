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
                PrecipitationView()
                WindView()
                HumidityView()
                UVView()
            }
            .padding(.horizontal)

        }

    }

}

#Preview {
    WeatherView()
}
