//
//  MapMarker.swift
//  Weather
//
//  Created by 이상수 on 5/29/25.
//

import SwiftUI

struct MapMarker: View {

    @ObservedObject var viewModel: MapViewModel
    let weatherReport: WeatherReport
    
    var body: some View {
        VStack(spacing: 0) {
            let value = viewModel.value(weatherReport: weatherReport)
            textIcon(value: value)
            pointer(value: value)
        }
    }

    private func textIcon(value: Int) -> some View {
        Text("\(value)")
            .font(.system(size: 13))
            .foregroundColor(.white)
            .padding(5)
            .background(viewModel.color(value: value))
            .clipShape(Circle())
    }

    private func pointer(value: Int) -> some View {
        Image(systemName: "arrowtriangle.down.fill")
            .font(.system(size: 8))
            .foregroundColor(viewModel.color(value: value))
    }

}
