//
//  HourlyForecastView.swift
//  Weather
//
//  Created by 이상수 on 5/27/25.
//

import SwiftUI

struct HourlyForecastView: View {

    let kmaViewModel: KMAViewModel

    var body: some View {

        VStack(alignment: .leading) {
            title
            hourlyForecasts
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .opacity(0.8)
        )

    }

    private var title: some View {
        Text("시간별 일기예보")
            .font(.caption)
            .foregroundStyle(.gray)
    }

    private var hourlyForecasts: some View {
        ScrollView(.horizontal, showsIndicators: false){
            let hourlyInfo = kmaViewModel.hourlyInfo(forNext: 24)
            let count = hourlyInfo.count
            HStack {
                ForEach(0..<count, id: \.self) { index in
                    HourlyForecastItem(
                        time: hourlyInfo[index].time,
                        iconName: hourlyInfo[index].sky,
                        temperature: hourlyInfo[index].temp
                    )
                }
            }
        }
    }

}

#Preview {
    HourlyForecastView(kmaViewModel: .init())
}
