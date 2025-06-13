//
//  MapMenu.swift
//  Weather
//
//  Created by 이상수 on 5/29/25.
//

import SwiftUI

struct MapMenu: View {

    var body: some View {
        Menu {

            Button("강수량") {

            }

            Button("기온") {

            }

            Button("미세먼지 농도") {

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

#Preview {
    MapMenu()
}
