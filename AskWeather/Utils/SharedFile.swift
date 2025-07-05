//
//  SharedFile.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/28/25.
//

import SwiftUI

enum SharedFile {

    private static let appGroupID = "group.com.soo127.Weather"

    static var widgetWeatherURL: URL {
        let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroupID)!
        return url.appendingPathComponent("weather.json")
    }

}
