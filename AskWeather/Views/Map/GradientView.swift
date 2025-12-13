//
//  GradientView.swift
//  AskWeather
//
//  Created by 이상수 on 6/30/25.
//

import SwiftUI

struct GradientView: View {
    
    let menuType: MapMenuType

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(menuType.title)
                .font(.caption)
                .bold()

            LinearGradient(
                gradient: Gradient(colors: menuType.legendColors),
                startPoint: .leading,
                endPoint: .trailing
            )
            .frame(height: 8)
            .cornerRadius(4)

            HStack {
                ForEach(menuType.legendValues, id: \.self) { value in
                    Text("\(value)")
                        .font(.caption2)
                    Spacer()
                }
            }
        }
        .padding(8)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .frame(width: 150)
    }
    
}

