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
    @Published var coordinate: CLLocationCoordinate2D?
    @Published var showWeather = false
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

extension LocationSearchViewModel {

    @MainActor
    func handleSearch(completion: MKLocalSearchCompletion) async {
        defer { dismissKeyboard() }

        let request = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: request)
        do {
            let response = try await search.start()
            guard let coordinate = response.mapItems.first?.placemark.coordinate else {
                return
            }
            self.coordinate = coordinate
            self.showWeather = true
        } catch {
            print("검색 실패: \(error)")
        }
    }

    private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

}

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        results = completer.results
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: any Error) {
        print("자동완성 실패: \(error.localizedDescription)")
    }

}
