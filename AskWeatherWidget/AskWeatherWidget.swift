//
//  AskWeatherWidget.swift
//  AskWeatherWidget
//
//  Created by 이상수 on 6/28/25.
//

import WidgetKit
import SwiftUI

struct AskWeatherWidgetEntryView : View {

    var entry: Provider.Entry

    var body: some View {
        VStack(spacing: 3) {
            address
            HStack {
                temperature
                skyIcon
            }
            wind
            uv
            airPollution
        }
    }

    private var address: some View {
        Text(entry.weather.address)
            .font(.system(size: 20))
            .foregroundColor(.white.opacity(0.85))
            .multilineTextAlignment(.center)
            .lineLimit(2)
    }

    private var temperature: some View {
        Text("\(entry.weather.temperature)°")
            .font(.system(size: 35, weight: .bold, design: .rounded))
            .foregroundColor(.white)
            .shadow(radius: 2)
    }

    private var skyIcon: some View {
        Image(systemName: entry.weather.skyName)
            .font(.system(size: 35))
            .foregroundColor(.white)
            .shadow(radius: 2)
    }

    private var wind: some View {
        Label("\(entry.weather.windSpeed, specifier: "%.1f") m/s", systemImage: "wind")
            .font(.subheadline)
            .foregroundColor(.white.opacity(0.85))
    }

    private var uv: some View {
        Text("자외선: \(entry.weather.uvLevel)")
            .font(.caption)
            .foregroundColor(.white.opacity(0.85))
    }

    private var airPollution: some View {
        Text("대기질: \(entry.weather.pollutionLevel)")
            .font(.caption)
            .foregroundColor(.white.opacity(0.85))
    }
    
}

struct AskWeatherWidget: Widget {
    
    let background = LinearGradient(
        gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.cyan]),
        startPoint: .top,
        endPoint: .bottom
    )
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "AskWeatherWidget", provider: Provider()) { entry in
            AskWeatherWidgetEntryView(entry: entry)
                .containerBackground(background, for: .widget)
        }
    }
    
}

#Preview(as: .systemSmall) {
    AskWeatherWidget()
} timeline: {
    WeatherEntry(date: .now, weather: .empty)
}
