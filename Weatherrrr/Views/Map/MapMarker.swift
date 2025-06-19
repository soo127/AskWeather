//
//  MapMarker.swift
//  Weather
//
//  Created by 이상수 on 5/29/25.
//

import SwiftUI

struct MapMarker: View {

    let temperature: Int

    var body: some View {
        VStack(spacing: 0) {
            Text("\(temperature)°")
                .foregroundColor(.white)
                .padding(5)
                .background(WeatherFormatter.temperatureColor(temperature))
                .clipShape(Circle())

            Image(systemName: "arrowtriangle.down.fill")
                .font(.system(size: 8))
                .foregroundColor(WeatherFormatter.temperatureColor(temperature))
                .offset(y: -3)
        }
    }

}
