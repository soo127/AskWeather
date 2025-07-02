//
//  CityContainer.swift
//  Weather
//
//  Created by 이상수 on 5/29/25.
//

import SwiftUI

struct CityContainer: View {

    @EnvironmentObject private var weatherStorage: WeatherStorage

    var body: some View {
        NavigationStack {
            List {
                searchBar
                favoriteCities
            }
            .navigationTitle("날씨")
            .scrollIndicators(.hidden)
            .padding(.horizontal)
            .toolbar {
                removeButton
            }
            .listStyle(.plain)
        }
    }

    private var removeButton: some View {
        Button {
            weatherStorage.handleRemove()
        } label: {
            Image(systemName: weatherStorage.isEditMode ? "checkmark" : "trash")
        }
    }

    private var favoriteCities: some View {
        ForEach(weatherStorage.favorites) { weatherReport in
            CityCard(report: weatherReport)
                .padding(.vertical, 5)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
                .background(
                    NavigationLink("", destination: WeatherView(viewModel: .from(weatherReport)))
                        .opacity(0)
                )
        }
        .onMove { indices, newOffset in
            weatherStorage.favorites.move(fromOffsets: indices, toOffset: newOffset)
        }
    }
    
    private var searchBar: some View {
        HStack {
            Label("도시 검색", systemImage: "magnifyingglass")
                .foregroundStyle(.gray)
            Spacer()
        }
        .padding(7)
        .background(RoundedRectangle(cornerRadius: 8)
            .fill(Color.gray.opacity(0.1))
        )
        .padding(.bottom)
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets())
        .listRowBackground(Color.clear)
        .background(
            NavigationLink("", destination: CitySearchView())
                .opacity(0)
        )
    }

}
