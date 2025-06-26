//
//  SearchedCityView.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/17/25.
//

import SwiftUI

struct SearchedCityView: View {

    @EnvironmentObject private var weatherStorage: WeatherStorage
    @ObservedObject var viewModel: LocationSearchViewModel

    var body: some View {
        NavigationStack {
            WeatherView(coordinate: viewModel.coordinate, address: viewModel.address)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("취소") {
                            viewModel.showWeather = false
                        }
                    }
                    if !weatherStorage.hasFavorite(coordinate: viewModel.coordinate) {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("추가") {
                                weatherStorage.addFavorite(coordinate: viewModel.coordinate, address: viewModel.address)
                                viewModel.showWeather = false
                            }
                        }
                    }
                }
        }
    }

}

