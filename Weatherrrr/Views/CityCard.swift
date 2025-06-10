//
//  CityCard.swift
//  Weather
//
//  Created by 이상수 on 5/29/25.
//

import SwiftUI

struct CityCard: View {

    var body: some View {

        HStack(alignment: .center) {

            VStack(alignment: .leading, spacing: 5) {
                Text("화성시")
                    .font(.title2)

                Text("맑음")
                    .font(.subheadline)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 5) {
                Text("24°")
                    .font(.largeTitle)
                    .fontWeight(.semibold)

                Text("최고 20°, 최저 12°")
                    .font(.caption)
                    .foregroundColor(.gray)
            }

        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.gray.opacity(0.3))
        )

    }
    
}

#Preview {
    CityCard()
}
