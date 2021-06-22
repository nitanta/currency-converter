//
//  PickerDbWorkerTests.swift
//  currency-converterTests
//
//  Created by Nitanta Adhikari on 6/22/21.
//

import XCTest
@testable import currency_converter

final class PickerDbWorkerTests: XCTestCase {
    
    var sut: PickerDbWorkerMock!
        
    override func setUp() {
        super.setUp()
        
        sut = PickerDbWorkerMock()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}

final class PickerDbWorkerMock: PickerDbWorkerLogic {
    func getSavedRates() -> ExchangeRataDefinable? {
        return ExchangeRateMock(id: "USD", code: "USD", timestamp: Date(), rates: RatesResponse.stubSuccessModel?.quotes ?? [:])
    }
    
    func getCurrentCountryCode() -> String {
        return Global.defaultCode
    }
    
    func saveCurrentRate(code: String, rate: Double) {}
    func saveCountry(code: String) {}
    
    func loadSavedCountry() -> CurrentCountryDefinable {
        return CurrentCountryMock(id: "COUNTRY", code: "USD")
    }
    
    func loadSavedRate() -> (code: String, source: String, rate: Double)? {
        return (code: "AUD", source: "USD", rate: 1.30)
    }
    func saveNewRate() -> (code: String, source: String, rate: Double)? {
        return (code: "AUD", source: "USD", rate: 1.30)
    }
    
    func hasCurrentRateSaved() -> Bool {
        return false
    }
    
    func getCurrentCurrencyCode() -> String? {
        return Global.defaultCode
    }
    func updateCurrentCurrencyRate(rate: Double) {}
    
}

