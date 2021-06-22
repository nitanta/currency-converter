//
//  CountriesWorkerTests.swift
//  currency-converterTests
//
//  Created by Nitanta Adhikari on 6/22/21.
//

import XCTest
@testable import currency_converter

final class CountriesWorkerTests: XCTestCase {
    
    var sut: CountriesWorkerMock!
        
    override func setUp() {
        super.setUp()
        
        sut = CountriesWorkerMock()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_countryWorker_successDataSupplied_countryListContainsData() {
        
        let expectation1 = expectation(description: "Wait for load countries to return")
        sut.makeCountriesStub = .success(CountryResponse.stubCountriesModel)
        
        var countries: [CountryResponse] = []
        sut.fetchCountries { (result) in
            switch result {
            case .success(let response):
                countries = response
            case .failure: break
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            expectation1.fulfill()
        }
        waitForExpectations(timeout: 0.1)
        
        XCTAssertFalse(countries.isEmpty)
    }
    
    func test_countryWorker_failureData_countryListContainsData() {
        
        let expectation1 = expectation(description: "Wait for load countries to return")
        sut.makeCountriesStub = .failure(APIProviderErrors.decodingError)
        
        var countries: [CountryResponse] = []
        sut.fetchCountries { (result) in
            switch result {
            case .success(let response):
                countries = response
            case .failure: break
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            expectation1.fulfill()
        }
        waitForExpectations(timeout: 0.1)
        
        XCTAssertTrue(countries.isEmpty)
    }
}
