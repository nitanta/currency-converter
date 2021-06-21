//
//  CountryManagerTests.swift
//  currency-converterTests
//
//  Created by Nitanta Adhikari on 6/20/21.
//

import XCTest
@testable import currency_converter

final class CountriesManagerTests: XCTestCase {
    
    var sut: CountryManager!
        
    override func setUp() {
        super.setUp()
        
        sut = CountryManager()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_countryManager_loadCountry_countryListContainsData() {
        
        let expectation1 = expectation(description: "Wait for countries to load")
        
        var countries: [CountryResponse] = []
        sut.loadCountries { (result) in
            switch result {
            case .success(let response):
                countries = response
            case .failure: break
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation1.fulfill()
        }
        waitForExpectations(timeout: 1)
        
        XCTAssertFalse(countries.isEmpty)
    }
}
