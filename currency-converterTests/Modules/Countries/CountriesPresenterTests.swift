//
//  CountriesPresenterTests.swift
//  currency-converterTests
//
//  Created by Nitanta Adhikari on 6/20/21.
//

import XCTest
@testable import currency_converter

final class CountriesPresenterTests: XCTestCase {
    
    var sut: CountriesPresenter!
    var vc: CountriesPresenterOutputMock!
        
    override func setUp() {
        super.setUp()
        
        sut = CountriesPresenter()
        vc = CountriesPresenterOutputMock()
        sut.viewController = vc
    }
    
    override func tearDown() {
        sut = nil
        vc = nil
        super.tearDown()
    }
    
    func test_countriesPresenter_showCountriesListCalled() {
        sut.showCountryList(list: [])
        XCTAssertTrue(vc.showCountriesListCalled)
    }
    
    func test_countriesPresenter_showLoaderCalled() {
        sut.showLoader(show: true)
        XCTAssertTrue(vc.showLoaderCalled)
    }
    
    func test_countriesPresenter_goBackCalled() {
        sut.goBack()
        XCTAssertTrue(vc.goBackCalled)
    }
    
    func test_countriesPresenter_showErrorCalled() {
        sut.showFailure(message: "")
        XCTAssertTrue(vc.showErrorCalled)
    }
}

final class CountriesPresenterOutputMock: CountriesPresenterOutput {
    var showCountriesListCalled: Bool = false
    func showCountriesList(list: [CountryResponse]) {
        showCountriesListCalled = true
    }
    
    var showLoaderCalled: Bool = false
    func showLoader(show: Bool) {
        showLoaderCalled = true
    }
    
    var goBackCalled: Bool = false
    func goBack() {
        goBackCalled = true
    }
    
    var showErrorCalled: Bool = false
    func showError(message: String) {
        showErrorCalled = true
    }
    
}
