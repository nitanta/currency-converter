//
//  CountriesInteractorTests.swift
//  currency-converterTests
//
//  Created by Nitanta Adhikari on 6/20/21.
//

import XCTest
@testable import currency_converter

final class CountriesInteractorTests: XCTestCase {
    
    private var sut: CountriesInteractor!
    private var presenter: CountriesPresenterInputMock!
    private var countriesWorker: CountriesWorkerMock!
    private var pickerDbWorker: PickerDbWorkerMock!
    
    override func setUp() {
        super.setUp()
        
        sut = CountriesInteractor()
        presenter = CountriesPresenterInputMock()
        countriesWorker = CountriesWorkerMock()
        pickerDbWorker = PickerDbWorkerMock()
        
        sut.presenter = presenter
        sut.worker = countriesWorker
        sut.dbWorker = pickerDbWorker
        
    }
    
    override func tearDown() {
        
        sut = nil
        presenter = nil
        countriesWorker = nil
        pickerDbWorker = nil
        
        super.tearDown()
    }
    
    func test_countriesInteractor_whenViewLoaded_thenWorkerCalled() {
        sut.loadCountries()
        XCTAssertTrue(countriesWorker.fetchCountriesCalled)
    }
    
    func test_countriesInteractor_whenViewLoaded_showLoaderCalled() {
        sut.loadCountries()
        XCTAssertTrue(presenter.showLoaderCalled)
        XCTAssertTrue(presenter.showLoader)
    }
    
    func test_countriesInteractor_whenViewLoadedAndWorkerCalled_showLoaderRemoved() {
        let expectation1 = expectation(description: "Wait for load countries to return")
        countriesWorker.makeCountriesStub = .success(CountryResponse.stubCountriesModel)
        
        sut.loadCountries()
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            expectation1.fulfill()
        }
        waitForExpectations(timeout: 0.1)
        
        XCTAssertTrue(presenter.showLoaderCalled)
        XCTAssertFalse(presenter.showLoader)
    }
    
    func test_countriesInteractor_whenWorkerCalledWithSuccessData_showCountriesListCalled() {
        let expectation1 = expectation(description: "Wait for load countries to return")
        countriesWorker.makeCountriesStub = .success(CountryResponse.stubCountriesModel)
        
        sut.loadCountries()
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            expectation1.fulfill()
        }
        waitForExpectations(timeout: 0.1)
        
        XCTAssertTrue(presenter.showCountryListCalled)
        XCTAssertEqual(presenter.countryListData, CountryResponse.stubCountriesModel)
    }
    
    func test_countriesInteractor_whenWorkerCalledWithFailureData_showFailureCalled() {
        let expectation1 = expectation(description: "Wait for load countries to return")
        countriesWorker.makeCountriesStub = .failure(APIProviderErrors.decodingError)
        
        sut.loadCountries()
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            expectation1.fulfill()
        }
        waitForExpectations(timeout: 0.1)
        
        XCTAssertTrue(presenter.showFailureMessageCalled)
        XCTAssertEqual(presenter.failureMessage, APIProviderErrors.decodingError.errorDescription.safeUnwrapped)
    }
    
    func test_countriesInteractor_whenLoadedDataSelected_goBackCalled() {
        sut.selectCountry(code: "USD")
        XCTAssertTrue(presenter.goBackCalled)
    }
}

private final class CountriesPresenterInputMock: CountriesPresenterInput {
    
    var showCountryListCalled: Bool = false
    var countryListData: [CountryResponse] = []
    func showCountryList(list: [CountryResponse]) {
        showCountryListCalled = true
        countryListData = list
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


final class CountriesWorkerMock: CountriesWorkerLogic {
    var fetchCountriesCalled: Bool = false
    var makeCountriesStub: Result<[CountryResponse], Error>?
    func fetchCountries(completion: @escaping (Result<[CountryResponse], Error>) -> Void) {
        fetchCountriesCalled = true
        if let stub = makeCountriesStub {
            completion(stub)
        }
    }
    
}
