//
//  Park.swift
//  vgs3-map
//
//  Created by Денис Наумов on 10.08.2021.
//  Copyright © 2021 Denis Naumov. All rights reserved.
//

import Foundation
import MapKit

struct Park {
    var name: String
    var polygon: MKPolygon
    
    init?(from feature: MKGeoJSONFeature) {
        guard
            let serializedProperties = feature.properties,
            let properties = try? JSONDecoder().decode(GeoJSONFeatureProrerties.self, from: serializedProperties),
            let name = properties.name,
            let polygon = feature.geometry.first as? MKPolygon
        else { return nil }

        self.name = name
        self.polygon = polygon
    }
}

struct GeoJSONFeatureProrerties: Decodable {
    var name: String?
}
