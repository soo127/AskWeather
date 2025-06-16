//
//  String+Extension.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/14/25.
//

import Foundation

extension String {

    /// yyyyMMddHHmm
    func date() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmm"
        return formatter.date(from: self)
    }

}
