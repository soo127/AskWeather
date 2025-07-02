//
//  GaugeBar.swift
//  Weatherrrr
//
//  Created by 이상수 on 7/2/25.
//

import SwiftUI

struct GaugeBar: View {
    
    private let value: CGFloat
    private let start: CGFloat
    private let end: CGFloat
    private let pointerSize: CGFloat = 8
    private let width: CGFloat = 150
    private let gradient = Gradient(colors: [.blue, .green, .yellow, .red, .purple])

    var body: some View {
        ZStack(alignment: .leading) {
            Capsule()
                .frame(width: width, height: 5)
                .foregroundStyle(
                    LinearGradient(
                        gradient: gradient,
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
            Circle()
                .fill(Color.white)
                .frame(width: pointerSize, height: pointerSize)
                .offset(x: pointerOffset())
                .shadow(radius: 1)
        }
    }

    private func pointerOffset() -> CGFloat {
        let clamped = min(max(value, start), end)
        let ratio = (clamped - start) / (end - start)
        return width * ratio - (pointerSize / 2)
    }
    
}

extension GaugeBar {
    
    init(value: Int, start: Int, end: Int) {
            self.value = CGFloat(value)
            self.start = CGFloat(start)
            self.end = CGFloat(end)
        }
    
}
