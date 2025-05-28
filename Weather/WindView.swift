//
//  WindView.swift
//  Weather
//
//  Created by 이상수 on 5/28/25.
//

import SwiftUI

struct WindView: View {

    let rotateAngle = 0.0

    var body: some View {
        VStack(alignment: .leading) {
            title
            windCompass
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.ultraThinMaterial)
        )
    }

    private var title: some View {
        Text("바람")
            .font(.caption)
            .foregroundStyle(.gray)
    }

    private var windCompass: some View {
        ZStack {
            compass
            arrow
            speed
        }
    }

    private var compass: some View {
        Group {
            Circle()
                .stroke(lineWidth: 5)
                .frame(width: 180, height: 180)
                .opacity(0.1)

            Text("N").offset(y: -80)
            Text("S").offset(y: 80)
            Text("E").offset(x: 80)
            Text("W").offset(x: -80)
        }
    }

    private var arrow: some View {
        Group {
            Text("----------------")
                .rotationEffect(.degrees(rotateAngle))

            let angle = Angle(degrees: rotateAngle).radians

            Image(systemName: "triangle.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .rotationEffect(.degrees(90+rotateAngle))
                .offset(x: 65 * cos(angle), y: 65 * sin(angle))
        }
    }

    private var speed: some View {
        Group {
            Circle()
                .frame(width: 60, height: 60)
                .foregroundStyle(.white)
            Text("2 m/s")
        }
    }

}

#Preview {
    WindView()
}
