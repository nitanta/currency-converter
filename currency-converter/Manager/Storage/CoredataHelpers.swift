//
//  CoredataHelpers.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/18/21.
//

import Foundation
import CoreData

class CoreDataHelpers {
    
    static func findFirst<T>(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor] = []) -> T? where T: NSManagedObject {
        
        let request = T.fetchRequest()
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        request.fetchLimit = 1
        
        do {
            let results = try CoreDataManager.shared.managedObjectContext.fetch(request)
            return results.first as! T
        } catch {
            return nil
        }
    }
    
}
