//
//  HourlyForecastView.swift
//  Weather
//
//  Created by 이상수 on 5/27/25.
//

import SwiftUI

struct HourlyForecastView: View {

    var body: some View {

        VStack(alignment: .leading) {

            Text("시간별 일기예보")
                .font(.caption)
                .foregroundStyle(.gray)

            ScrollView(.horizontal, showsIndicators: false){
                HStack {
                    ForEach(1...15, id: \.self) { index in
                        HourlyWeatherItem(time: index, iconName: "sun.max", temperature: 30-index)
                    }
                }
            }

        }

    }

}
