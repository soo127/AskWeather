//
//  WeatherCard.swift
//  Weather
//
//  Created by 이상수 on 5/28/25.
//

import SwiftUI

struct WeatherCard<Content: View>: View {

    var content: () -> Content

    var body: some View {

        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
                .opacity(0.8)
            content()
        }
        .frame(height: 190)

    }

}

