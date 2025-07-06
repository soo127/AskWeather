//
//  AirPollutionResponse.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/11/25.
//

extension AirPollutionAPI {

    struct AirPollutionResponse: Decodable {
        let response: Response
    }
    
    struct Response: Decodable {
        let body: Body
    }

    struct Body: Decodable {
        let items: [Item]
    }

    struct Item: Decodable {
        let seoul: Int?
        let busan: Int?
        let daegu: Int?
        let incheon: Int?
        let gwangju: Int?
        let daejeon: Int?
        let ulsan: Int?
        let gyeonggi: Int?
        let gangwon: Int?
        let chungbuk: Int?
        let chungnam: Int?
        let jeonbuk: Int?
        let jeonnam: Int?
        let gyeongbuk: Int?
        let gyeongnam: Int?
        let jeju: Int?
        let sejong: Int?

        // 기본 응답이 String, 아주 가끔 값이 없기도 하므로 미리 Int로 변환 (필요에 따라 Property wrapper로 리팩토링 가능)
        enum CodingKeys: String, CodingKey {
            case seoul, busan, daegu, incheon, gwangju, daejeon, ulsan
            case gyeonggi, gangwon, chungbuk, chungnam, jeonbuk, jeonnam
            case gyeongbuk, gyeongnam, jeju, sejong
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.seoul = try? DecodingHelper.toInt(from: container, forKey: .seoul)
            self.busan = try? DecodingHelper.toInt(from: container, forKey: .busan)
            self.daegu = try? DecodingHelper.toInt(from: container, forKey: .daegu)
            self.incheon = try? DecodingHelper.toInt(from: container, forKey: .incheon)
            self.gwangju = try? DecodingHelper.toInt(from: container, forKey: .gwangju)
            self.daejeon = try? DecodingHelper.toInt(from: container, forKey: .daejeon)
            self.ulsan = try? DecodingHelper.toInt(from: container, forKey: .ulsan)
            self.gyeonggi = try? DecodingHelper.toInt(from: container, forKey: .gyeonggi)
            self.gangwon = try? DecodingHelper.toInt(from: container, forKey: .gangwon)
            self.chungbuk = try? DecodingHelper.toInt(from: container, forKey: .chungbuk)
            self.chungnam = try? DecodingHelper.toInt(from: container, forKey: .chungnam)
            self.jeonbuk = try? DecodingHelper.toInt(from: container, forKey: .jeonbuk)
            self.jeonnam = try? DecodingHelper.toInt(from: container, forKey: .jeonnam)
            self.gyeongbuk = try? DecodingHelper.toInt(from: container, forKey: .gyeongbuk)
            self.gyeongnam = try? DecodingHelper.toInt(from: container, forKey: .gyeongnam)
            self.jeju = try? DecodingHelper.toInt(from: container, forKey: .jeju)
            self.sejong = try? DecodingHelper.toInt(from: container, forKey: .sejong)
        }
    }

}

extension AirPollutionAPI.Item {

    func value(area: Area) -> Int? {
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
