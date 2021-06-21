//
//  CurrentCurrency.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/19/21.
//

import Foundation
import CoreData

protocol CurrentCurrencyDefinable {
    var id: String { get set }
    var code: String { get set }
    var source: String { get set }
    var rate: Double { get set }
}

struct CurrentCurrencyMock: CurrentCurrencyDefinable {
    var id: String
    var code: String
    var source: String
    var rate: Double
}

class CurrentCurrency: NSManagedObject, DatabaseManageable, CurrentCurrencyDefinable {
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<CurrentCurrency> {
        return NSFetchRequest<CurrentCurrency>(entityName: "CurrentCurrency")
    }

    @NSManaged var id: String
    @NSManaged var code: String
    @NSManaged var source: String
    @NSManaged var rate: Double
    
    static func saveCurrencyCode(_ code: String, source: String, rate: Double) -> CurrentCurrency {
        let localCurrency: CurrentCurrency!
        if let currency = findFirst(predicate: NSPredicate(format: "id == %@", "CURRENCY"), type: CurrentCurrency.self) {
            localCurrency = currency
        } else {
            localCurrency = CurrentCurrency(context: CoreDataManager.shared.managedObjectContext)
        }
        
        localCurrency.id = "CURRENCY"
        localCurrency.code = code
        localCurrency.source = source
        localCurrency.rate = rate
        return localCurrency
    }
    
    static func hasCurrencySaved() -> Bool {
        let currency = findFirst(predicate: NSPredicate(format: "id == %@", "CURRENCY"), type: CurrentCurrency.self)
        return currency != nil
    }
    
    static func findCurrencySaved() -> CurrentCurrency? {
        let currency = findFirst(predicate: NSPredicate(format: "id == %@", "CURRENCY"), type: CurrentCurrency.self)
        return currency
    }
    
    static func updateRate(rate: Double) {
        guard let currency = findFirst(predicate: NSPredicate(format: "id == %@", "CURRENCY"), type: CurrentCurrency.self) else { return }
        currency.rate = rate
    }
}
