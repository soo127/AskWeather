//
//  AirStagnationView.swift
//  Weather
//
//  Created by 이상수 on 5/29/25.
//

import SwiftUI

struct AirStagnationView: View {

    var body: some View {

        VStack(alignment: .leading) {
            title
            stagnationLevel
        }
        .padding()

    }

    private let gradient = Gradient(colors: [
        .blue, .green, .yellow, .orange, .red, .brown
    ])

    private var title: some View {
        Text("대기 정체 지수")
            .font(.caption)
            .foregroundStyle(.gray)
    }

    private var stagnationLevel: some View {
        Group {
            Text("10")
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
    AirStagnationView()
}
