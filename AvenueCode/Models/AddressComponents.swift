//
//  AddressComponents.swift
//  AvenueCode
//
//  Created by Swagat Mishra on 6/2/18.
//  Copyright © 2018 Swagat Mishra. All rights reserved.
//

import Foundation

class AddressComponents: Codable {
    var longName: String?
    var shortName: String?
    var types: [String]?
    
    enum CodingKeys: String, CodingKey {
        case longName = "long_name"
        case shortName = "short_name"
        case types
    }
}
