//
//  CountryResponse.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/18/21.
//

import Foundation

struct CountryResponse: Codable {
    let code, emoji, unicode, name: String
    let title: String
    let dialCode: String?
}
