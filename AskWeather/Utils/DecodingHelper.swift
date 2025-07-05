//
//  DecodingHelper.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/18/25.
//

import Foundation

enum DecodingHelper {

    static func toInt<K: CodingKey> (
        from container: KeyedDecodingContainer<K>,
        forKey key: K
    ) throws -> Int {
        let string = try container.decode(String.self, forKey: key)
        guard let value = Int(string) else {
            throw FetchError.decodingFailure
        }
        return value
    }

}
