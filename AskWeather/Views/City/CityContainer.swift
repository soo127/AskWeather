//
//  CityContainer.swift
//  AskWeather
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
        // list에서 화살표 숨기기 위함
        .background(
            NavigationLink("", destination: CitySearchView())
                .opacity(0)
        )
        .background(.background)
    }
    
    private var favoriteCities: some View {
        ForEach(weatherStorage.favorites.values) { report in
            Group {
                if weatherStorage.isEditMode {
                    editingView(report: report)
                } else {
                    readingView(report: report)
                }
            }
            .padding(.vertical, 4)
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets())
        }
        .onMove { indices, newOffset in
            weatherStorage.moveFavorites(fromOffsets: indices, toOffset: newOffset)
        }
    }
    
    private func editingView(report: WeatherReport) -> some View {
        Button {
            weatherStorage.toggleFavorite(id: report.id)
        } label: {
            HStack {
                Image(systemName: weatherStorage.isSelected(id: report.id) ? "checkmark.circle" : "circle")
                    .resizable()
                    .frame(width: 25, height: 25)
                CityCard(report: report)
            }
        }
    }
    
    private func readingView(report: WeatherReport) -> some View {
        CityCard(report: report)
            .background(
                NavigationLink("", destination: WeatherView(viewModel: .from(report)))
                    .opacity(0)
            )
    }
    
    private var removeButton: some View {
        Button {
            weatherStorage.handleRemove()
        } label: {
            Image(systemName: weatherStorage.isEditMode ? "checkmark" : "trash")
        }
    }

}
