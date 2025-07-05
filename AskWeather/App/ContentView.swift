//
//  ContentView.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/8/25.
//

import SwiftUI
import CoreLocation

struct ContentView: View {

    let report: WeatherReport

    var body: some View {
        TabView {
            MapView()
                .tabItem {
                    Image(systemName: "map")
                }
            WeatherView(viewModel: .from(report))
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
    ContentView(report: .empty)
}
