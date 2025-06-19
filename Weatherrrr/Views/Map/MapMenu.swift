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
            menuButton(type: .uvIndex, title: "자외선")
            menuButton(type: .airPollution, title: "미세먼지")
            menuButton(type: .temperature, title: "기온")
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

    @ViewBuilder
    private func menuButton(type: MapMenuType, title: String) -> some View {
        Button {
            viewModel.select(type: type)
        } label: {
            Label {
                Text(title)
            } icon: {
                if viewModel.menuType == type {
                    Image(systemName: "checkmark")
                }
            }
        }
    }

}
