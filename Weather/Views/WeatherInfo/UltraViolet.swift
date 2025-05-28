//
//  UltraViolet.swift
//  Weather
//
//  Created by 이상수 on 5/28/25.
//

import SwiftUI

struct UltraViolet: View {

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
            Text("4")
                .font(.title)
            Text("보통")
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

#Preview {
    UltraViolet()
}
