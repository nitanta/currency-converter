//
//  Utilities.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/18/21.
//

import Foundation
import UIKit

struct Utilities {
    
    static let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
    static func loadStub<D: Decodable>(url: URL) -> D? {
        let data = try! Data(contentsOf: url)
        do {
            let d = try jsonDecoder.decode(D.self, from: data)
            return d
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func loadStubData(url: URL) -> Data? {
        let data = try! Data(contentsOf: url)
        return data
    }
       
}
