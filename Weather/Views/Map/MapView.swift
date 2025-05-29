//
//  MapView.swift
//  Weather
//
//  Created by 이상수 on 5/29/25.
//

import SwiftUI
import MapKit

extension CLLocationCoordinate2D {
    static let seoul = Self(latitude: 37.5665, longitude: 126.9780)
    static let busan = Self(latitude: 35.1796, longitude: 129.0756)
}

struct MapView: View {

    var body: some View {

        ZStack(alignment: .topTrailing) {
            Map {
                Annotation("Seoul", coordinate: .seoul) {
                    MapMarker(temperature: 25)
                }

                Annotation("Busan", coordinate: .busan) {
                    MapMarker(temperature: 19)
                }
            }
            MapMenu()
        }
    }

}

#Preview {
    MapView()
}
