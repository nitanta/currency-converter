//
//  RatesResponse.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/18/21.
//

import Foundation

struct RatesResponse: Codable {
    let success: Bool
    let errorMessage: ErrorMessage?
    let terms, privacy: String?
    let timestamp: Int?
    let source: String?
    let quotes: [String: Double]?
    
    enum CodingKeys: String, CodingKey {
        case success, terms, privacy, timestamp, source, quotes
        case errorMessage = "error"
    }
}

struct ErrorMessage: Codable {
    let code: Int
    let type: String?
    let info: String
}

extension RatesResponse {
    static var stubSuccessModel: RatesResponse? {
        let url = Bundle.main.url(forResource: "RateResponseSuccess", withExtension: "json")!
        let response: RatesResponse? = Utilities.loadStub(url: url)
        return response
        
    }
    static var stubFailureModel: RatesResponse? {
        let url = Bundle.main.url(forResource: "RateResponseFail", withExtension: "json")!
        let response: RatesResponse? = Utilities.loadStub(url: url)
        return response
    }
}

