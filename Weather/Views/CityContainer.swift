//
//  CityContainer.swift
//  Weather
//
//  Created by 이상수 on 5/29/25.
//

import SwiftUI

struct CityContainer: View {

    @EnvironmentObject var locationManager: LocationManager

    var body: some View {

        NavigationStack {

            ScrollView {

                TextField("Search City", text: .constant(""))
                    .padding(.vertical, 5)
                    .background(Color.gray.opacity(0.1))
                    .padding(.bottom)

                ForEach(1...5, id: \.self) { i in
                    NavigationLink(destination: WeatherView()) {
                        CityCard()
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
            }
            .navigationTitle("날씨")
            .scrollIndicators(.hidden)
            .padding(.horizontal)
        }

    }

}

#Preview {
    CityContainer()
        .environmentObject(LocationManager())
}


