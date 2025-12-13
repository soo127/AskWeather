//
//  Provider.swift
//  AskWeather
//
//  Created by 이상수 on 6/29/25.
//

import WidgetKit

struct Provider: TimelineProvider {
    
    func placeholder(in context: Context) -> WeatherEntry {
        WeatherEntry(date: Date(), weather: .empty)
    }

    func getSnapshot(in context: Context, completion: @escaping (WeatherEntry) -> Void) {
        let entry = WeatherEntry(date: Date(), weather: .empty)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<WeatherEntry>) -> Void) {
        let now = Date()
        let entry: WeatherEntry
        do {
            entry = WeatherEntry(date: now, weather: try loadWidgetWeather())
        } catch {
            entry = WeatherEntry(date: now, weather: .empty)
        }

        let next = now.nextHour() ?? now.addingTimeInterval(3600)
        completion(Timeline(entries: [entry], policy: .after(next)))
    }

    private func loadWidgetWeather() throws -> WidgetWeather {
        let data = try Data(contentsOf: SharedFile.widgetWeatherURL)
        return try JSONDecoder().decode(WidgetWeather.self, from: data)
    }

}

