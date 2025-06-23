//
//  MapView.swift
//  Weather
//
//  Created by 이상수 on 5/29/25.
//

import SwiftUI
import MapKit

struct MapView: View {

    @StateObject private var mapViewModel = MapViewModel()
    @EnvironmentObject private var weatherStorage: WeatherStorage

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Map {
                currentMarker
                favoriteMarkers
            }
            MapMenu(viewModel: mapViewModel)
        }
    }

    @MapContentBuilder
    private var currentMarker: some MapContent {
        let current = weatherStorage.currentWeather
        Annotation("현재 위치", coordinate: current.coordinate) {
            MapMarker(viewModel: mapViewModel, weatherReport: current)
        }
    }

    @MapContentBuilder
    private var favoriteMarkers: some MapContent {
        ForEach(weatherStorage.favorites) { report in
            Annotation(report.address, coordinate: report.coordinate) {
                MapMarker(
                    viewModel: mapViewModel,
                    weatherReport: report
                )
            }
        }
    }

}
