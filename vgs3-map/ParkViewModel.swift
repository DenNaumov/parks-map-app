//
//  ParkViewModel.swift
//  vgs3-map
//
//  Created by Денис Наумов on 25.08.2021.
//  Copyright © 2021 Denis Naumov. All rights reserved.
//

import MapKit

struct ParkViewModel {
    var polygonCoordinates: MKPolygon
    var displayName: String
    var annotationCoordinate: CLLocationCoordinate2D
    
    init(from item: Park) {
        polygonCoordinates = item.polygon
        displayName = item.name
        annotationCoordinate = item.polygon.coordinate
    }
}
