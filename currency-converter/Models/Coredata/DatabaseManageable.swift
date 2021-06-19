//
//  DatabaseManageable.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/18/21.
//

import Foundation
import CoreData

protocol DatabaseManageable {
    static var database: CoreDataManager { get }
    static func findFirst<T: NSManagedObject>(predicate: NSPredicate?, type: T.Type) throws -> T?
}

extension DatabaseManageable {
    static var database: CoreDataManager {
        return CoreDataManager.shared
    }
    
    static func findFirst<T: NSManagedObject>(predicate: NSPredicate?, type: T.Type) -> T? {
        let entityName = String(describing: T.self)
        let request = NSFetchRequest<T>(entityName: entityName)
        request.fetchLimit = 1
        request.predicate = predicate
        do {
            guard let data = try database.managedObjectContext.fetch(request).first else { return nil }
            return data
        } catch {
            return nil
        }
    }
}
