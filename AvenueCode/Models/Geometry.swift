//
//  Geometry.swift
//  AvenueCode
//
//  Created by Swagat Mishra on 6/2/18.
//  Copyright © 2018 Swagat Mishra. All rights reserved.
//

import Foundation

class Geometry: Codable {
    var bounds: Bounds?
    var location: LocationCoordinates?
    var locationType: String?
    var viewport: ViewPort?
    
    enum CodingKeys: String, CodingKey {
        case locationType = "location_type"
        case bounds, location, viewport
    }
}
