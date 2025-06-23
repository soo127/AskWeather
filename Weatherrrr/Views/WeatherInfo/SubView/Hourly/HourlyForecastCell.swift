//
//  HourlyForecastCell.swift
//  Weather
//
//  Created by 이상수 on 5/27/25.
//

import SwiftUI

struct HourlyForecastCell: View {

    let viewModel: ViewModel

    var body: some View {
        VStack(spacing: 5) {
            Text(viewModel.date)
            viewModel.icon
            Text(viewModel.temperature)
        }
        .padding(.horizontal, 5)
    }

}

extension HourlyForecastCell {

    struct ViewModel: Identifiable {
        let id = UUID()
        let date: String
        let icon: Image
        let temperature: String
    }

}

extension HourlyForecastCell.ViewModel {

    init(forecast: Forecast) {
        self.date = forecast.date.formatHourTo12H()
        self.icon = ForecastProcessor.skyIcon(forecast: forecast)
        self.temperature = "\(forecast.temperature)°"
    }

}
