//
//  TitleView.swift
//  Weather
//
//  Created by 이상수 on 6/5/25.
//

import SwiftUI

struct TitleView: View {

    let kmaViewModel: KMAViewModel
    let addressManager: AddressManager

    var body: some View {

        VStack(spacing: 5) {
            Text(addressManager.address ?? "주소 로딩 중...")
                .font(.title2)
            Text("\(kmaViewModel.temperature ?? .zero, specifier: "%.0f")°")
                .font(.largeTitle)
            HStack {
                Text("최고: \(kmaViewModel.dailyHighTemp(afterdays: 0) ?? .zero, specifier: "%.0f")° ")
                Text("최저: \(kmaViewModel.dailyLowTemp(afterdays: 0) ?? .zero, specifier: "%.0f")° ")
            }
        }
        .padding(.vertical)

    }
}

//#Preview {
//    TitleView()
//}
