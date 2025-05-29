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
                .background(temperatureColor)
                .clipShape(Circle())

            Image(systemName: "arrowtriangle.down.fill")
                .font(.system(size: 8))
                .foregroundColor(temperatureColor)
                .offset(y: -3)
        }

    }

    private var temperatureColor: Color {
        switch temperature {
        case ..<0: return .blue
        case 0..<10: return .cyan
        case 10..<20: return .green
        case 20..<30: return .orange
        default: return .red
        }
    }

}
