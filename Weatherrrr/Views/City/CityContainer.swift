//
//  CityContainer.swift
//  Weather
//
//  Created by 이상수 on 5/29/25.
//

import SwiftUI

struct CityContainer: View {

    var body: some View {
        NavigationStack {
            ScrollView {
                searchBar
                ForEach(1...5, id: \.self) { i in
                    NavigationLink(destination: WeatherView()) {
                        CityCard()
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .navigationTitle("날씨")
            .scrollIndicators(.hidden)
            .padding(.horizontal)
            .toolbar {
                MenuView()
            }
        }
    }

    private var searchBar: some View {
        NavigationLink(destination: CitySearchView()) {
            HStack {
                Label("도시 검색", systemImage: "magnifyingglass")
                    .foregroundStyle(.gray)
                Spacer()
            }
            .padding(7)
            .background(Color.gray.opacity(0.1))
            .padding(.bottom, 7)
        }
        .buttonStyle(PlainButtonStyle())
    }

}

#Preview {
    CityContainer()
        .environmentObject(MainViewModel())
}


