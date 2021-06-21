//
//  ExchangeRates.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/18/21.
//

import Foundation
import CoreData

protocol ExchangeRataDefinable {
    var id: String { get set }
    var code: String { get set }
    var timestamp: Date { get set }
    var rates: [String: Double] { get set }
}

struct ExchangeRateMock: ExchangeRataDefinable {
    var id: String
    var code: String
    var timestamp: Date
    var rates: [String : Double]
}

class ExchangeRates: NSManagedObject, DatabaseManageable, ExchangeRataDefinable {
    
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
        if let quotes = rates.quotes {
            var formattedQuotes: [String: Double] = [:]
            quotes.forEach {
                var sourceKey = $0.key
                sourceKey.removeFirst(rates.source.safeUnwrapped.count)
                formattedQuotes[sourceKey] = $0.value
            }
            localRates.rates = formattedQuotes
        }
        return localRates
    }
    
    static func getRates(code: String) -> ExchangeRates? {
        let excRate = findFirst(predicate: NSPredicate(format: "id == %@", code), type: ExchangeRates.self)
        return excRate
    }
}
