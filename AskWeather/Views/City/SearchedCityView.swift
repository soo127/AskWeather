//
//  SearchedCityView.swift
//  AskWeather
//
//  Created by 이상수 on 6/17/25.
//

import SwiftUI

struct SearchedCityView: View {
    
    @EnvironmentObject private var weatherStorage: WeatherStorage
    @ObservedObject var viewModel: WeatherViewModel
    @Binding var showWeather: Bool
    
    var body: some View {
        NavigationStack {
            WeatherView(viewModel: viewModel)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("취소") {
                            showWeather = false
                        }
                    }
                    if !(viewModel.isLoading || weatherStorage.hasFavorite(id: viewModel.weatherReport.id)) {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("추가") {
                                weatherStorage.addFavorite(report: viewModel.weatherReport)
                                showWeather = false
                            }
                        }
                    }
                }
        }
    }

}

