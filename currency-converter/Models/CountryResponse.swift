//
//  CountryResponse.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/18/21.
//

import Foundation

struct CountryResponse: Codable, Equatable {
    let code, emoji, unicode, name: String
    let title: String
    let dialCode: String?
}

extension CountryResponse {
    /// Load stub data
    static var stubCountriesModel: [CountryResponse] {
        let url = Bundle.main.url(forResource: "Countries", withExtension: "json")!
        let response: [CountryResponse]? = try? Utilities.loadStub([CountryResponse].self, from: url)
        return response ?? []
    }
}
