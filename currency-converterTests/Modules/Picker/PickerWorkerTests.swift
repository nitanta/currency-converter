//
//  PickerWorkerTests.swift
//  currency-converterTests
//
//  Created by Nitanta Adhikari on 6/22/21.
//

import XCTest
@testable import currency_converter

final class PickerWorkerTests: XCTestCase {
    
    var sut: PickerWorkerMock!
        
    override func setUp() {
        super.setUp()
        
        sut = PickerWorkerMock()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_pickerWorker_successDataSupplied_rateListContainsData() {
        
        let expectation1 = expectation(description: "Wait for load rates to return")
        sut.makeRatesStub = .success(RatesResponse.stubSuccessModel?.quotes ?? [:])
        
        var rates: [String: Double] = [:]
        sut.fetchRates(forCountryCode: Global.defaultCode) { (result) in
            switch result {
            case .success(let response):
                rates = response
            case .failure: break
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            expectation1.fulfill()
        }
        waitForExpectations(timeout: 0.1)
        
        XCTAssertFalse(rates.isEmpty)
    }
    
    func test_countryWorker_failureData_countryListContainsData() {
        
        let expectation1 = expectation(description: "Wait for load rates to return")
        sut.makeRatesStub = .failure(APIProviderErrors.decodingError)
        
        var rates: [String: Double] = [:]
        sut.fetchRates(forCountryCode: Global.defaultCode) { (result) in
            switch result {
            case .success(let response):
                rates = response
            case .failure: break
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            expectation1.fulfill()
        }
        waitForExpectations(timeout: 0.1)
        
        XCTAssertTrue(rates.isEmpty)
    }
}
