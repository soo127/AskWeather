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
            let coordinate = viewModel.coordinate
            let address = viewModel.address
            
            WeatherView(viewModel: .from(coordinate: coordinate, address: address))
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("취소") {
                            viewModel.showWeather = false
                        }
                    }
                    if !weatherStorage.hasFavorite(coordinate: coordinate) {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("추가") {
                                weatherStorage.addFavorite(coordinate: coordinate, address: address)
                                viewModel.showWeather = false
                            }
                        }
                    }
                }
        }
    }

}

