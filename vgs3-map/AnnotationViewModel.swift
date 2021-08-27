//
//  AnnotationViewModel.swift
//  vgs3-map
//
//  Created by Денис Наумов on 25.08.2021.
//  Copyright © 2021 Denis Naumov. All rights reserved.
//

import Foundation
import MapKit


class AnnotationViewModel: NSObject, MKAnnotation {

    var coordinate = CLLocationCoordinate2D(latitude: 55.8383, longitude: 37.6171)
    var title: String?
    
    override init() {
        super.init()
    }
    
    convenience init(coordinate: CLLocationCoordinate2D, title: String) {
        self.init()
        self.title = title
        self.coordinate = coordinate
    }
}
