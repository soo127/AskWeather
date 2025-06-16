//
//  AirPollutionResponse.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/11/25.
//

struct AirPollutionResponse: Decodable {

    let response: Response

    struct Response: Decodable {
        let body: Body
    }

    struct Body: Decodable {
        let items: [Item]
    }

    struct Item: Decodable {
        let seoul: String?
        let busan: String?
        let daegu: String?
        let incheon: String?
        let gwangju: String?
        let daejeon: String?
        let ulsan: String?
        let gyeonggi: String?
        let gangwon: String?
        let chungbuk: String?
        let chungnam: String?
        let jeonbuk: String?
        let jeonnam: String?
        let gyeongbuk: String?
        let gyeongnam: String?
        let jeju: String?
        let sejong: String?
    }

}

extension AirPollutionResponse.Item {

    func value(area: Area) -> String? {
        switch area {
        case .seoul:
            return self.seoul
        case .busan:
            return self.busan
        case .daegu:
            return self.daegu
        case .incheon:
            return self.incheon
        case .gwangju:
            return self.gwangju
        case .daejeon:
            return self.daejeon
        case .ulsan:
            return self.ulsan
        case .gyeonggi:
            return self.gyeonggi
        case .gangwon:
            return self.gangwon
        case .chungbuk:
            return self.chungbuk
        case .chungnam:
            return self.chungnam
        case .jeonbuk:
            return self.jeonbuk
        case .jeonnam:
            return self.jeonnam
        case .gyeongbuk:
            return self.gyeongbuk
        case .gyeongnam:
            return self.gyeongnam
        case .jeju:
            return self.jeju
        case .sejong:
            return self.sejong
        }
    }

}
