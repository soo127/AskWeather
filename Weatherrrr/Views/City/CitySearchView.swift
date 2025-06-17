//
//  CitySearchView.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/12/25.
//

import SwiftUI

struct CitySearchView: View {

    @StateObject var viewModel = LocationSearchViewModel()
    @EnvironmentObject private var weatherViewModel: WeatherViewModel

    var body: some View {
        VStack {
            searchField
            searchResults
        }
        .padding(.horizontal)
        .fullScreenCover(isPresented: $viewModel.showWeather) {
            SearchedCityView(viewModel: viewModel)
        }
    }

    private var searchField: some View {
        TextField("도시 검색", text: $viewModel.queryFragment)
            .padding()
            .background(RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.1))
                .frame(height: 40)
            )
            .padding(.bottom)
    }

    private var searchResults: some View {
        ScrollView {
            ForEach(viewModel.searchResults, id: \.self) { completion in
                Button {
                    viewModel.handleSearchSelection(completion: completion)
                } label: {
                    Text(completion.title)
                }
                .padding(.vertical, 5)
                .buttonStyle(PlainButtonStyle())

            }
        }
    }

}

#Preview {
    CitySearchView()
}
