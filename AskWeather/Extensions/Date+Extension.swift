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
    
    /// Check if it is between 6 and 18 o'clock
    func isNight() -> Bool {
        let hour = Calendar.current.component(.hour, from: self)
        return hour < 6 || hour >= 18
    }
    
    /// 5:35 -> 6:00
    func nextHour() -> Date? {
        let calendar = Calendar.current
        guard let next = calendar.date(byAdding: .hour, value: 1, to: self) else {
            return nil
        }
        return calendar.date(bySettingHour: calendar.component(.hour, from: next), minute: 0, second: 0, of: next)
    }

}
