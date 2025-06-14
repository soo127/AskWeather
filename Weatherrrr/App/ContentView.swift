//
//  ContentView.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/8/25.
//

import SwiftUI

struct ContentView: View {

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
