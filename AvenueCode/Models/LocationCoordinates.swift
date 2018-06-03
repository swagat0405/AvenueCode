//
//  LocationCoordinates.swift
//  AvenueCode
//
//  Created by Swagat Mishra on 6/2/18.
//  Copyright © 2018 Swagat Mishra. All rights reserved.
//

import Foundation

class LocationCoordinates: Codable, CustomStringConvertible {
    var lat: Double
    var lng: Double
    
    var description: String {
        return "( \(lat) - \(lng))"
    }
}
