//
//  Provider.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/29/25.
//

import WidgetKit

struct Provider: AppIntentTimelineProvider {

    func placeholder(in context: Context) -> WeatherEntry {
        WeatherEntry(date: Date(), weather: .empty)
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> WeatherEntry {
        WeatherEntry(date: Date(), weather: .empty)
    }

    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<WeatherEntry> {
        let now = Date()
        let entry: WeatherEntry
        do {
            entry = WeatherEntry(date: now, weather: try loadWidgetWeather())
        } catch {
            entry = WeatherEntry(date: now, weather: .empty)
        }

        let nextExactHour = nextHour(from: now)
        return Timeline(entries: [entry], policy: .after(nextExactHour))
    }

    func loadWidgetWeather() throws -> WidgetWeather {
        let data = try Data(contentsOf: SharedFile.widgetWeatherURL)
        return try JSONDecoder().decode(WidgetWeather.self, from: data)
    }

    func nextHour(from date: Date) -> Date {
        let calendar = Calendar.current
        let nextHour = calendar.date(byAdding: .hour, value: 1, to: date)!
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: nextHour)
        return calendar.date(from: components)!
    }

}
