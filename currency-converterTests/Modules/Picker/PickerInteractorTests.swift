//
//  PickerInteractorTests.swift
//  currency-converterTests
//
//  Created by Nitanta Adhikari on 6/20/21.
//

import XCTest
@testable import currency_converter

final class PickerInteractorTests: XCTestCase {
    
    private var sut: PickerInteractor!
    private var presenter: PickerPresenterInputMock!
    private var pickerWorker: PickerWorkerMock!
    private var pickerDbWorker: PickerDbWorkerLogic!
    
    override func setUp() {
        super.setUp()
        
        sut = PickerInteractor()
        presenter = PickerPresenterInputMock()
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
    
    func test_pickerInteractor_whenViewLoaded_thenWorkerCalled() {
        sut.loadRates()
        XCTAssertTrue(pickerWorker.fetchRatesCalled)
    }
    
    func test_pickerInteractor_whenViewLoaded_showLoaderCalled() {
        sut.loadRates()
        XCTAssertTrue(presenter.showLoaderCalled)
        XCTAssertTrue(presenter.showLoader)
    }
    
    func test_pickerInteractor_whenViewLoadedAndWorkerCalled_showLoaderRemoved() {
        let expectation1 = expectation(description: "Wait for load rates to return")
        pickerWorker.makeRatesStub = .success(RatesResponse.stubSuccessModel?.quotes ?? [:])
        
        sut.loadRates()
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            expectation1.fulfill()
        }
        waitForExpectations(timeout: 0.1)
        
        XCTAssertTrue(presenter.showLoaderCalled)
        XCTAssertFalse(presenter.showLoader)
    }
    
    func test_pickerInteractor_whenWorkerCalledWithSuccessData_showCurrencyListCalled() {
        let expectation1 = expectation(description: "Wait for load rates to return")
        pickerWorker.makeRatesStub = .success(RatesResponse.stubSuccessModel?.quotes ?? [:])
        
        sut.loadRates()
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            expectation1.fulfill()
        }
        waitForExpectations(timeout: 0.1)
        
        XCTAssertTrue(presenter.showRateListCalled)
        XCTAssertEqual(presenter.rateList, RatesResponse.stubSuccessModel?.quotes ?? [:])
    }
    
    func test_pickerInteractor_whenWorkerCalledWithFailureData_showFailureCalled() {
        let expectation1 = expectation(description: "Wait for load countries to return")
        pickerWorker.makeRatesStub = .failure(APIProviderErrors.decodingError)
        
        sut.loadRates()
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            expectation1.fulfill()
        }
        waitForExpectations(timeout: 0.1)
        
        XCTAssertTrue(presenter.showFailureMessageCalled)
        XCTAssertEqual(presenter.failureMessage, APIProviderErrors.decodingError.errorDescription.safeUnwrapped)
    }
    
    func test_pickerInteractor_whenLoadedDataSelected_goBackCalled() {
        sut.selectRate(code: "USD", rate: 1.0)
        XCTAssertTrue(presenter.goBackCalled)
    }
}

private final class PickerPresenterInputMock: PickerPresenterInput {
    
    var showRateListCalled: Bool = false
    var rateList: [String: Double]!
    func showRatesList(list: [String : Double]) {
        showRateListCalled = true
        rateList = list
    }
    
    
    var showFailureMessageCalled: Bool = false
    var failureMessage: String!
    func showFailure(message: String) {
        showFailureMessageCalled = true
        failureMessage = message
    }
    
    var goBackCalled: Bool = false
    func goBack() {
        goBackCalled = true
    }
    
    var showLoaderCalled: Bool = false
    var showLoader: Bool!
    func showLoader(show: Bool) {
        showLoaderCalled = true
        showLoader = show
    }
    
}


final class PickerWorkerMock: PickerWorkerLogic {
    var fetchRatesCalled: Bool = false
    var makeRatesStub: Result<[String : Double], Error>?
    func fetchRates(forCountryCode: String, completion: @escaping (Result<[String : Double], Error>) -> Void) {
        fetchRatesCalled = true
        if let stub = makeRatesStub {
            completion(stub)
        }
    }
    
}
