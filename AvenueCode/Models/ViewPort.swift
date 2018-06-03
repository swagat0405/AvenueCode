//
//  ViewPort.swift
//  AvenueCode
//
//  Created by Swagat Mishra on 6/2/18.
//  Copyright © 2018 Swagat Mishra. All rights reserved.
//

import Foundation

class ViewPort: Codable {
    var northeast: LocationCoordinates?
    var southwest: LocationCoordinates?
    
    enum CodingKeys: String, CodingKey {
        case northeast, southwest
    }
}
