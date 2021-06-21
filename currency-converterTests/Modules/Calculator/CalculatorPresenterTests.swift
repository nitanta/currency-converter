//
//  CalculatorPresenterTests.swift
//  currency-converterTests
//
//  Created by Nitanta Adhikari on 6/20/21.
//

import XCTest
@testable import currency_converter

final class CalculatorPresenterTests: XCTestCase {
    
    var sut: CalculatorPresenter!
    var vc: CalculatorPresenterOutputMock!
        
    override func setUp() {
        super.setUp()
        
        sut = CalculatorPresenter()
        vc = CalculatorPresenterOutputMock()
        sut.viewController = vc
    }
    
    override func tearDown() {
        sut = nil
        vc = nil
        super.tearDown()
    }
    
    func test_calculatorPresenter_showLoaderCalled() {
        sut.showLoader(show: true)
        XCTAssertTrue(vc.showLoaderCalled)
    }
    
    func test_pickerPresenter_showErrorCalled() {
        sut.showFailure(message: "")
        XCTAssertTrue(vc.showErrorCalled)
    }
    
    func test_pickerPresenter_showDefaultCountryCalled() {
        sut.showDefaultCountry(code: "USD")
        XCTAssertTrue(vc.showDefaultCountryCalled)
    }
    
    func test_pickerPresenter_showDefaultCurrentRateCalled() {
        sut.showDefaultCurrencyRate(code: "USD", source: "NPR", rate: 0.2)
        XCTAssertTrue(vc.showDefaultCurrentRateCalled)
    }
    
    func test_pickerPresenter_showConvertedValueCalled() {
        sut.showConvertedData(value: "20")
        XCTAssertTrue(vc.showConvertedValueCalled)
    }
}

final class CalculatorPresenterOutputMock: CalculatorPresenterOutput {
    
    var showDefaultCountryCalled: Bool = false
    func showDefaultCountry(code: String) {
        showDefaultCountryCalled = true
    }
    
    var showDefaultCurrentRateCalled: Bool = false
    func showDefaultCurrencyRate(code: String, source: String, rate: Double) {
        showDefaultCurrentRateCalled = true
    }
    
    var showConvertedValueCalled: Bool = false
    func showConvertedValue(value: String) {
        showConvertedValueCalled = true
    }
    
    var showLoaderCalled: Bool = false
    func showLoader(show: Bool) {
        showLoaderCalled = true
    }
    
    var showErrorCalled: Bool = false
    func showError(message: String) {
        showErrorCalled = true
    }
}
