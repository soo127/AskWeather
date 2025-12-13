//
//  SharedFile.swift
//  AskWeather
//
//  Created by 이상수 on 6/28/25.
//

import SwiftUI

enum SharedFile {

    private static let appGroupID = "group.com.soo127.Weather"

    static var widgetWeatherURL: URL {
        guard let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroupID) else {
            fatalError("appGroupID이 적합하지 않습니다.")
        }
        return url.appendingPathComponent("weather.json")
    }

}
