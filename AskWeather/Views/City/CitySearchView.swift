//
//  CitySearchView.swift
//  AskWeather
//
//  Created by 이상수 on 6/12/25.
//

import SwiftUI

struct CitySearchView: View {

    @StateObject var viewModel = LocationSearchViewModel()
    @EnvironmentObject private var weatherStorage: WeatherStorage
    @State private var showWeather = false

    var body: some View {
        VStack {
            searchField
            searchResults
        }
        .padding(.horizontal)
        .fullScreenCover(isPresented: $showWeather) {
            SearchedCityView(
                viewModel: .from(coordinate: viewModel.coordinate, address: viewModel.address),
                showWeather: $showWeather
            )
        }
    }

    private var searchField: some View {
        TextField("도시 검색", text: $viewModel.queryFragment)
            .padding()
            .background(RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.1))
                .frame(height: 40)
            )
            .autocorrectionDisabled(true)
            .padding(.bottom)
    }

    private var searchResults: some View {
        ScrollView {
            ForEach(viewModel.searchResults, id: \.self) { completion in
                Button {
                    Task { @MainActor in
                        await viewModel.handleSearch(completion: completion)
                        showWeather = true
                    }
                } label: {
                    Text(completion.title)
                }
                .padding(.vertical, 5)
                .buttonStyle(PlainButtonStyle())
            }
        }
    }

}
