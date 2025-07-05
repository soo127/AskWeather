//
//  MapView.swift
//  Weather
//
//  Created by 이상수 on 5/29/25.
//

import SwiftUI
import MapKit

struct MapView: View {

    @StateObject private var viewModel = MapViewModel()
    @EnvironmentObject private var weatherStorage: WeatherStorage
    @State private var cameraPosition: MapCameraPosition = .region(MapViewModel.koreaRegion)

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Map(
                position: $cameraPosition,
                bounds: MapViewModel.cameraBounds
            ) {
                currentMarker
                favoriteMarkers
            }
            .overlay(alignment: .topTrailing) {
                VStack {
                    MapMenu(viewModel: viewModel)
                    locationButton
                }
                .padding(.top, 60)
                .padding(.trailing, 5)
            }
            .overlay(alignment: .bottomTrailing) {
                GradientView(menuType: viewModel.menuType)
            }
        }
    }
    
    private var locationButton: some View {
        Button {
            cameraPosition = .camera(
                MapCamera(centerCoordinate: weatherStorage.currentWeather.coordinate, distance: 50000)
            )
        } label: {
            Image(systemName: "paperplane")
                .font(.title)
                .foregroundStyle(.white)
                .padding(5)
                .background(.black.opacity(0.6))
                .clipShape(RoundedRectangle(cornerRadius: 5))
        }
    }

    @MapContentBuilder
    private var currentMarker: some MapContent {
        let current = weatherStorage.currentWeather
        Annotation("현재 위치", coordinate: current.coordinate) {
            MapMarker(viewModel: viewModel, weatherReport: current)
        }
    }

    @MapContentBuilder
    private var favoriteMarkers: some MapContent {
        ForEach(weatherStorage.favorites) { report in
            Annotation(report.address, coordinate: report.coordinate) {
                MapMarker(
                    viewModel: viewModel,
                    weatherReport: report
                )
            }
        }
    }

}
