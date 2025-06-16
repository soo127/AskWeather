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

}
