//
//  ContentView.swift
//  Weather
//
//  Created by 이상수 on 5/27/25.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var contentViewModel = ContentViewModel()

    var body: some View {
        TabView {
            MapView()
                .tabItem {
                    Image(systemName: "map")
                }
            WeatherView()
                .tabItem {
                    Image(systemName: "paperplane")
                }
            CityContainer()
                .tabItem {
                    Image(systemName: "list.bullet")
                }
        }
    }
    
}

#Preview {
    ContentView()
}
