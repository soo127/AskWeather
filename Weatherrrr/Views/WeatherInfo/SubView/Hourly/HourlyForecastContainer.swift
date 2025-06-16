//
//  HourlyForecastContainer.swift
//  Weather
//
//  Created by 이상수 on 5/27/25.
//

import SwiftUI

struct HourlyForecastContainer: View {

    @EnvironmentObject private var weatherViewModel : WeatherViewModel

    var body: some View {
        VStack(alignment: .leading) {
            title
            hourlyForecasts
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .opacity(0.8)
        )
    }

    private var title: some View {
        Text("시간별 일기예보")
            .font(.caption)
            .foregroundStyle(.gray)
    }

    private var hourlyForecasts: some View {
        ScrollView(.horizontal, showsIndicators: false){
            let viewModels = weatherViewModel.todayHourlyViewModels()
            HStack {
                ForEach(viewModels) { viewModel in
                    HourlyForecastCell(viewModel: viewModel)
                }
            }
        }
    }

}

#Preview {
    HourlyForecastContainer()
}
