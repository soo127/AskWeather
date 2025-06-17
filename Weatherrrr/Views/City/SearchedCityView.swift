//
//  SearchedCityView.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/17/25.
//

import SwiftUI

struct SearchedCityView: View {

    @EnvironmentObject private var weatherViewModel: WeatherViewModel
    @ObservedObject var viewModel: LocationSearchViewModel

    var body: some View {
        NavigationStack {
            WeatherView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("취소") {
                            viewModel.showWeather = false
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("추가") {
                            //viewModel.confirmSelection()
                        }
                    }
                }
                .onAppear {
                    if let coordinate = viewModel.coordinate {
                        Task { await weatherViewModel.load(coordinate: coordinate) }
                    }
                }
        }
    }

}

