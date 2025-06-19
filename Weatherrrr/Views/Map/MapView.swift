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
                ForEach(weatherStorage.stored) { report in
                    Annotation(report.address, coordinate: report.coordinate) {
                        MapMarker(
                            viewModel: mapViewModel,
                            weatherReport: report
                        )
                    }
                }
            }
            MapMenu(viewModel: mapViewModel)
        }
    }

}

#Preview {
    MapView()
        .environmentObject(WeatherStorage())
}
