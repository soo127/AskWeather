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
                .stroke(lineWidth: 4)
                .frame(width: 135, height: 135)
                .opacity(0.1)

            Text("N").offset(y: -60)
            Text("S").offset(y: 60)
            Text("E").offset(x: 60)
            Text("W").offset(x: -60)
        }
    }

    private var arrow: some View {
        Group {
            Text("------------------")
                .font(.caption)
                .rotationEffect(.degrees(rotateAngle))

            let angle = Angle(degrees: rotateAngle).radians

            Image(systemName: "triangle.fill")
                .resizable()
                .frame(width: 15, height: 15)
                .rotationEffect(.degrees(90+rotateAngle))
                .offset(x: 48 * cos(angle), y: 48 * sin(angle))
        }
    }

    private var speed: some View {
        Group {
            Circle()
                .frame(width: 45, height: 45)
                .foregroundStyle(.white)
            Text("2 ")
            + Text("m/s")
                .font(.caption)
        }
    }

}

#Preview {
    WindView()
}
