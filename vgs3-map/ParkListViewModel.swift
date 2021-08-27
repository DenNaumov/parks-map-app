//
//  ListViewModel.swift
//  vgs3-map
//
//  Created by Денис Наумов on 09.08.2021.
//  Copyright © 2021 Denis Naumov. All rights reserved.
//

import Foundation
import MapKit

class ParkListViewModel: NSObject {
    let defaultCenterLocation = CLLocationCoordinate2D(latitude: 55.8383, longitude: 37.6171)
    var model = Model()
    var parks = [ParkViewModel]()
    let mapBoundary: MKMapView.CameraBoundary!
    var centerPoint: CLLocationCoordinate2D
    var selectedPark: ParkViewModel? = nil {
        willSet {
            if let park = newValue {
                centerPoint = park.annotationCoordinate
            } else {
                centerPoint = defaultCenterLocation
            }
        }
    }

    override init() {
        centerPoint = defaultCenterLocation
        mapBoundary = MKMapView.CameraBoundary(coordinateRegion: MKCoordinateRegion(
            center: defaultCenterLocation,
            span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
        ))

        super.init()
        loadParks()
    }
    
    private func loadParks() {
        guard let url = Bundle.main.url(forResource: "parks", withExtension: ".geojson") else {
            fatalError("GeoJSON file not found")
        }
        if let data = try? Data(contentsOf: url) {
            parse(geoJsonData: data)
        }
    }
    
    private func parse(geoJsonData: Data) {
        guard let features = try? MKGeoJSONDecoder().decode(geoJsonData) as? [MKGeoJSONFeature] else {
            fatalError("GeoJSON file has wrong format")
        }
        
        model.parks = features.compactMap { Park(from: $0) }
        parks = model.parks.compactMap { ParkViewModel(from: $0) }
    }

    func setSelectedPark(index: Int?) {
        if let index = index {
            let park = model.parks[index]
            model.selectedPark = park
            selectedPark = ParkViewModel(from: park)
        } else {
            selectedPark = nil
            model.selectedPark = nil
        }
    }
    
    func getSelectedPark() -> ParkViewModel? {
        guard let park = model.selectedPark else { return nil }
        return ParkViewModel(from: park)
    }

    func getDisplayedParks() -> [ParkViewModel] {
        if let park = model.selectedPark {
            return [ParkViewModel(from: park)]
        } else {
            return model.parks.compactMap { ParkViewModel(from: $0) }
        }
    }
}
