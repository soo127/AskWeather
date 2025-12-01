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
    private let gradient = Gradient(colors: [.blue, .green, .yellow, .red, .purple])

    var body: some View {
        GeometryReader { geometry in
            // 부모 너비(WeatherCard)의 95% 를 bar 너비로 사용
            let width = geometry.size.width * 0.95
            
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
                    .offset(x: pointerOffset(width: width))
                    .shadow(radius: 1)
            }
            .frame(width: geometry.size.width, alignment: .leading)
        }
        .frame(height: 20)
    }

    private func pointerOffset(width: CGFloat) -> CGFloat {
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
