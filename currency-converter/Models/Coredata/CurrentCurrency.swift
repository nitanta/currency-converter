//
//  CurrentCurrency.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/19/21.
//

import Foundation
import CoreData


class CurrentCurrency: NSManagedObject, DatabaseManageable {
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<CurrentCurrency> {
        return NSFetchRequest<CurrentCurrency>(entityName: "CurrentCurrency")
    }

    @NSManaged var id: String
    @NSManaged var code: String
    
    static func saveCurrencyCode(_ code: String) -> CurrentCurrency {
        let localCurrency: CurrentCurrency!
        if let currency = findFirst(predicate: NSPredicate(format: "id == %@", "CURRENCY"), type: CurrentCurrency.self) {
            localCurrency = currency
        } else {
            localCurrency = CurrentCurrency(context: CoreDataManager.shared.managedObjectContext)
        }
        
        localCurrency.id = "CURRENCY"
        localCurrency.code = code
        return localCurrency
    }
    
    static func hasCurrencySaved() -> Bool {
        let currency = findFirst(predicate: NSPredicate(format: "id == %@", "CURRENCY"), type: CurrentCurrency.self)
        return currency != nil
    }
}
