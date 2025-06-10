//
//  FineDustView.swift
//  Weather
//
//  Created by 이상수 on 5/28/25.
//

import SwiftUI

struct FineDustView: View {

    var body: some View {

        VStack(alignment: .leading) {
            title
            dustLevel
        }
        .padding()

    }

    private let gradient = Gradient(colors: [
        .blue, .green, .yellow, .orange, .red, .brown
    ])

    private var title: some View {
        Text("미세먼지 농도")
            .font(.caption)
            .foregroundStyle(.gray)
    }

    private var dustLevel: some View {
        Group {
            Text("73")
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
    FineDustView()
}
