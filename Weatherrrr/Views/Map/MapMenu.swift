//
//  MapMenu.swift
//  Weather
//
//  Created by 이상수 on 5/29/25.
//

import SwiftUI

struct MapMenu: View {

    @ObservedObject var viewModel: MapViewModel

    var body: some View {
        Menu {
            Button("자외선") {
                viewModel.select(type: .uvIndex)
            }
            Button("미세먼지") {
                viewModel.select(type: .airPollution)
            }
            Button("기온") {
                viewModel.select(type: .temperature)
            }
        } label: {
            Image(systemName: "ellipsis.circle")
                .font(.title)
                .foregroundStyle(.white)
                .padding(5)
                .background(.black.opacity(0.6))
                .clipShape(RoundedRectangle(cornerRadius: 5))
        }
        .padding(.trailing)
    }

}
