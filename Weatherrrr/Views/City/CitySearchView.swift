//
//  CitySearchView.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/12/25.
//

import SwiftUI

struct CitySearchView: View {

    @StateObject private var viewModel = LocationSearchViewModel()

    var body: some View {
        VStack {
            searchField
            searchResults
        }
        .padding(.horizontal)
    }

    private var searchField: some View {
        TextField("도시 검색", text: $viewModel.queryFragment)
            .padding()
            .background(RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.1))
                .frame(height: 40)
            )
            .padding(.bottom)
    }

    private var searchResults: some View {
        ScrollView {
            ForEach(viewModel.searchResults, id: \.self) { completion in
                Button {
                    print(completion.title)
                } label: {
                    Text(completion.title)
                }
            }
        }
    }

}

#Preview {
    CitySearchView()
}
