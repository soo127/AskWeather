//
//  WeatherSection.swift
//  Weather
//
//  Created by 이상수 on 5/28/25.
//

import SwiftUI

struct WeatherSection<Content: View>: View {
    var content: () -> Content

    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 16)
                .fill(.blue)
                .opacity(0.2)
            content()
        }
        .frame(height: 190)
    }
}

