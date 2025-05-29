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
            Text("관심 지역에 대한 날씨 지도 뷰")
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
