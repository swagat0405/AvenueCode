//
//  GoogleLocations.swift
//  AvenueCode
//
//  Created by Swagat Mishra on 6/2/18.
//  Copyright © 2018 Swagat Mishra. All rights reserved.
//

import Foundation

class GoogleLocations: Codable {
    var results: [Location]
    
    var description: String {
        return results.description
    }
}
