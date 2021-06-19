//
//  ExchangeRates.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/18/21.
//

import Foundation
import CoreData


class ExchangeRates: NSManagedObject, DatabaseManageable {
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<ExchangeRates> {
        return NSFetchRequest<ExchangeRates>(entityName: "ExchangeRates")
    }

    @NSManaged var id: String
    @NSManaged var code: String
    @NSManaged var timestamp: Date
    @NSManaged var rates: [String: Double]
    
    static func saveRates(_ rates: RatesResponse) -> ExchangeRates {
        let localRates: ExchangeRates!
        if let excRate = findFirst(predicate: NSPredicate(format: "id == %@", rates.source.safeUnwrapped), type: ExchangeRates.self) {
            localRates = excRate
        } else {
             localRates = ExchangeRates(context: CoreDataManager.shared.managedObjectContext)
        }
        
        localRates.id = rates.source.safeUnwrapped
        localRates.code = rates.source.safeUnwrapped
        localRates.timestamp = Date(timeIntervalSince1970: TimeInterval(rates.timestamp ?? 0))
        localRates.rates = rates.quotes ?? [:]
        return localRates
    }
    
}
