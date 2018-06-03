//
//  Address.swift
//  AvenueCode
//
//  Created by Swagat Mishra on 6/2/18.
//  Copyright © 2018 Swagat Mishra. All rights reserved.
//

import UIKit
import CoreData

class Address: NSManagedObject {

    class func addToDatabase(location: Location, context: NSManagedObjectContext) throws {
        guard Address.searchInDatabase(location: location, inContext: context) == 0 else { return }
        let addr = Address(context: context)
        addr.uniqueId = location.placeId
        addr.address = location.formattedAddress
        addr.latitude = (location.geometry?.location?.lat)!
        addr.longitude = (location.geometry?.location?.lng)!
        do {
            try context.save()
        } catch {
            throw error
        }
    }
    
    class func delete(location: Location, context: NSManagedObjectContext) throws {
        guard Address.searchInDatabase(location: location, inContext: context) != 0 else { return }
        let request: NSFetchRequest<Address> = Address.fetchRequest()
        request.predicate = NSPredicate(format: "uniqueId = %@", location.placeId!)
        do {
            for locationObject in try context.fetch(request) {
                context.delete(locationObject)
            }
        } catch {
            throw error
        }
    }
    
    class func searchInDatabase(location: Location, inContext context: NSManagedObjectContext) -> Int {
        let request: NSFetchRequest<Address> = Address.fetchRequest()
        request.predicate = NSPredicate(format: "uniqueId = %@", location.placeId!)
        return (try? context.count(for: request)) ?? 0
    }
}
