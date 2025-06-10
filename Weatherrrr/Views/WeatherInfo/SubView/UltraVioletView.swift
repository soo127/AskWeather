//
//  UltraVioletView.swift
//  Weather
//
//  Created by 이상수 on 5/28/25.
//

import SwiftUI

struct UltraVioletView: View {

    let lifeweatherViewModel: LifeWeatherViewModel
    
    var body: some View {

        VStack(alignment: .leading) {
            title
            UVLevel
        }
        .padding()

    }

    private let gradient = Gradient(colors: [
        .green, .yellow, .orange, .red, .purple
    ])

    private var title: some View {
        Text("자외선 지수")
            .font(.caption)
            .foregroundStyle(.gray)
    }

    private var UVLevel: some View {
        Group {
            Text(lifeweatherViewModel.currentUVIndexValue ?? "0")
                .font(.title)
            Text(lifeweatherViewModel.currentUVIndexLevel ?? "0")
                .font(.title2)
            Capsule()
                .frame(width: 150, height: 5)
                .overlay(
                    LinearGradient(
                        gradient: gradient,
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
        }
    }

}
