//
//  CalculatorInteractorTests.swift
//  currency-converterTests
//
//  Created by Nitanta Adhikari on 6/20/21.
//

import XCTest
@testable import currency_converter

final class CalculatorInteractorTests: XCTestCase {
    
    private var sut: CalculatorInteractor!
    private var presenter: CalculatorPresenterInputMock!
    private var pickerWorker: PickerWorkerMock!
    private var pickerDbWorker: PickerDbWorkerLogic!
    
    override func setUp() {
        super.setUp()
        
        sut = CalculatorInteractor()
        presenter = CalculatorPresenterInputMock()
        pickerWorker = PickerWorkerMock()
        pickerDbWorker = PickerDbWorkerMock()

        sut.presenter = presenter
        sut.worker = pickerWorker
        sut.dbWorker = pickerDbWorker
        
    }
    
    override func tearDown() {
        
        sut = nil
        presenter = nil
        pickerWorker = nil
        pickerDbWorker = nil
        
        super.tearDown()
    }
    
    func test_calculatorInteractor_whenViewLoaded_thenLoadCurrentRateCalled() {
        sut.loadCurrentRate()
        XCTAssertTrue(presenter.showDefaultCurrentRateCalled)
        XCTAssertEqual(presenter.defaultCurrencyRate, 1.30)
        XCTAssertEqual(presenter.defaultCurrentSouce, "USD")
        XCTAssertEqual(presenter.defaultCurrentCode, "AUD")
    }
    
    func test_calculatorInteractor_whenViewLoaded_thenLoadCurrentCountryCalled() {
        sut.loadCurrentCountry()
        XCTAssertTrue(presenter.showDefaultCountryCalled)
        XCTAssertEqual(presenter.defaultCountry, "USD")
    }
    
    func test_calculatorInteractor_convertTapped_showConvertedDataCalled() {
        sut.convertCurrency(value: 2.0)
        XCTAssertTrue(presenter.showConvertedDataCalled)
        XCTAssertEqual(presenter.convertedData, String(format: "%.2f", Double(2.0 * 1.30)))
    }
    
    func test_calculatorInteractor_whenViewLoadedAndWorkerCalled_showLoaderCalled() {
        sut.loadRates(reload: false)
        XCTAssertTrue(presenter.showLoaderCalled)
        XCTAssertTrue(presenter.showLoader)
    }
    
    func test_calculatorInteractor_whenViewLoadedAndWorkerCalled_showLoaderRemoved() {
        let expectation1 = expectation(description: "Wait for load countries to return")
        pickerWorker.makeRatesStub = .success(RatesResponse.stubSuccessModel?.quotes ?? [:])
        
        sut.loadRates(reload: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            expectation1.fulfill()
        }
        waitForExpectations(timeout: 0.1)
        
        XCTAssertTrue(presenter.showLoaderCalled)
        XCTAssertFalse(presenter.showLoader)
    }
    
    func test_calculatorInteractor_whenWorkerCalledWithSuccessData_showDefaultCurrencyCallled() {
        let expectation1 = expectation(description: "Wait for load rates to return")
        pickerWorker.makeRatesStub = .success(RatesResponse.stubSuccessModel?.quotes ?? [:])
        
        sut.loadRates(reload: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            expectation1.fulfill()
        }
        waitForExpectations(timeout: 0.1)
        
        XCTAssertTrue(presenter.showDefaultCurrentRateCalled)
        XCTAssertEqual(presenter.defaultCurrencyRate, 1.30)
        XCTAssertEqual(presenter.defaultCurrentSouce, "USD")
        XCTAssertEqual(presenter.defaultCurrentCode, "AUD")
    }
    
    func test_calculatorInteractor_whenWorkerCalledWithFailureData_showFailureCalled() {
        let expectation1 = expectation(description: "Wait for load countries to return")
        pickerWorker.makeRatesStub = .failure(APIProviderErrors.decodingError)
        
        sut.loadRates(reload: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            expectation1.fulfill()
        }
        waitForExpectations(timeout: 0.1)
        
        XCTAssertTrue(presenter.showFailureMessageCalled)
        XCTAssertEqual(presenter.failureMessage, APIProviderErrors.decodingError.errorDescription.safeUnwrapped)
    }

}

private final class CalculatorPresenterInputMock: CalculatorPresenterInput {
    
    var showConvertedDataCalled: Bool = false
    var convertedData: String!
    func showConvertedData(value: String) {
        showConvertedDataCalled = true
        convertedData = value
    }
    
    var showDefaultCountryCalled: Bool = false
    var defaultCountry: String!
    func showDefaultCountry(code: String) {
        showDefaultCountryCalled = true
        defaultCountry = code
    }
    
    var showDefaultCurrentRateCalled: Bool = false
    var defaultCurrentCode: String!
    var defaultCurrentSouce: String!
    var defaultCurrencyRate: Double!
    func showDefaultCurrencyRate(code: String, source: String, rate: Double) {
        showDefaultCurrentRateCalled = true
        defaultCurrentCode = code
        defaultCurrentSouce = source
        defaultCurrencyRate = rate
    }
    
    var showFailureMessageCalled: Bool = false
    var failureMessage: String!
    func showFailure(message: String) {
        showFailureMessageCalled = true
        failureMessage = message
    }
    
    var showLoaderCalled: Bool = false
    var showLoader: Bool!
    func showLoader(show: Bool) {
        showLoaderCalled = true
        showLoader = show
    }
    
}
