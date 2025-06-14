//
//  LocationSearchViewModel.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/12/25.
//

import SwiftUI
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject {

    @Published var queryFragment: String = "" {
        didSet {
            completer.queryFragment = queryFragment
        }
    }
    @Published var results = [MKLocalSearchCompletion]()
    private let completer = MKLocalSearchCompleter()

    override init() {
        super.init()
        setup()
    }

    private func setup() {
        completer.delegate = self
        completer.resultTypes = [.address]
    }
    
    var searchResults: [MKLocalSearchCompletion]  {
        self.results.filter { $0.title.hasPrefix("대한민국") }
    }

}

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate{

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        results = completer.results
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: any Error) {
        print("자동완성 실패: \(error.localizedDescription)")
    }

}
