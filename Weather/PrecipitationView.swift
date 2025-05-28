//
//  PrecipitationView.swift
//  Weather
//
//  Created by 이상수 on 5/27/25.
//

import SwiftUI

struct PrecipitationView: View {

    var body: some View {

        VStack(alignment: .leading) {
            title
            precipitation
        }
        .padding()
    }

    private var title: some View {
        Text("강수량 (last 24h)")
            .font(.caption)
            .foregroundStyle(.gray)
    }

    private var precipitation: some View {
        Text("0mm")
            .font(.title2)
    }

}

#Preview {
    PrecipitationView()
}
