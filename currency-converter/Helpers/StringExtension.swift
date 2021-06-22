//
//  StringExtension.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/18/21.
//

import Foundation

public extension Optional where Wrapped == String {
    
    /// Unwrap string, return empty string when nil
    var safeUnwrapped: String {
        guard let self = self else { return "" }
        return self
    }
    
}
