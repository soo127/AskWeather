//
//  TitleView.swift
//  Weather
//
//  Created by 이상수 on 6/5/25.
//

import SwiftUI

struct TitleView: View {

    @EnvironmentObject private var weatherManager: WeatherManager
    @EnvironmentObject private var addressManager: AddressManager

    var body: some View {

        VStack(spacing: 5) {
            Text(addressManager.address ?? "주소 로딩 중...")
                .font(.title2)
            Text("\(weatherManager.temperature, specifier: "%.0f")°")
                .font(.largeTitle)
            Text("최고: \(weatherManager.getHighestTemp(later: 0), specifier: "%.0f")°, 최저: \(weatherManager.getLowestTemp(later: 0), specifier: "%.0f")°")
        }
        .padding(.vertical)

    }
}

//#Preview {
//    TitleView()
//}
