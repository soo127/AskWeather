//
//  Date+Extension.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/14/25.
//

import Foundation

extension Date {

    /// 20250614
    func dateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter.string(from: self)
    }

    /// 오후 6시
    func formatHourTo12H() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "a h시"
        return formatter.string(from: self)
    }

    /// Check if the given time match in hours
    func isSameHour(comparedTo date: Date) -> Bool {
        let calendar = Calendar.current
        let components: Set<Calendar.Component> = [.year, .month, .day, .hour]
        return calendar.dateComponents(components, from: self)
            == calendar.dateComponents(components, from: date)
    }

}
