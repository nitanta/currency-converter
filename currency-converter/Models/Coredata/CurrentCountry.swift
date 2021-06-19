//
//  CurrentCountry.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/19/21.
//

import Foundation
import CoreData


class CurrentCountry: NSManagedObject, DatabaseManageable {
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<CurrentCountry> {
        return NSFetchRequest<CurrentCountry>(entityName: "CurrentCountry")
    }

    @NSManaged var id: String
    @NSManaged var code: String
    
    static func saveCountryCode(_ code: String) -> CurrentCountry {
        let localCountry: CurrentCountry!
        if let country = findFirst(predicate: NSPredicate(format: "id == %@", "COUNTRY"), type: CurrentCountry.self) {
            localCountry = country
        } else {
            localCountry = CurrentCountry(context: CoreDataManager.shared.managedObjectContext)
        }
        
        localCountry.id = "COUNTRY"
        localCountry.code = code
        return localCountry
    }
    
    static func hasCountrySaved() -> Bool {
        let country = findFirst(predicate: NSPredicate(format: "id == %@", "COUNTRY"), type: CurrentCountry.self)
        return country != nil
    }
    
    static func findCountrySaved() -> CurrentCountry? {
        let country = findFirst(predicate: NSPredicate(format: "id == %@", "COUNTRY"), type: CurrentCountry.self)
        return country
    }
    
}
