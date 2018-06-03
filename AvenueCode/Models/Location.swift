//
//  Location.swift
//  AvenueCode
//
//  Created by Swagat Mishra on 6/2/18.
//  Copyright © 2018 Swagat Mishra. All rights reserved.
//

import Foundation

class Location: Codable {
    var addressComponents: [AddressComponents]?
    var formattedAddress: String?
    var geometry: Geometry?
    var placeId: String?
    var types: [String]?
    
    enum CodingKeys: String, CodingKey {
        case addressComponents = "address_components"
        case formattedAddress = "formatted_address"
        case placeId = "place_id"
        case geometry, types
    }
}
