//
//  CalculatorViewControllerTests.swift
//  currency-converterTests
//
//  Created by Nitanta Adhikari on 6/20/21.
//

import XCTest
@testable import currency_converter

final class CalculatorViewControllerTests: XCTestCase {
    
    private var sut: CalculatorViewController!
    private var interactor: CalculatorInteractorSpy!
    private var router: CalculatorRouterSpy!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "CalculatorViewController") as? CalculatorViewController
        
        interactor = CalculatorInteractorSpy()
        router = CalculatorRouterSpy()
        
        sut.output = interactor
        sut.router = router
        
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        interactor = nil
        router = nil
        super.tearDown()
    }
    
    func test_calculatorScene_viewLoaded_loadCountryCalled() {
        XCTAssertTrue(interactor.loadCurrentRateCalled)
    }
    
    func test_calculatorScene_viewLoaded_loadRatesCalled() {
        XCTAssertTrue(interactor.loadRatesCalled)
    }
    
    func test_calculatorScene_viewLoaded_loadCurrentRateCalled() {
        XCTAssertTrue(interactor.loadCurrentRateCalled)
    }
    
    func test_calculatorScene_viewLoaded_convertCurrencyCalled() {
        sut.convertedValueLbl.text = "1.0"
        let button = UIButton()
        button.tag = 20
        sut.numberBtnTapped(button)
        XCTAssertTrue(interactor.convertCurrencyCalled)
    }
    
    func test_calculatorScence_navBarTap_countryPickerCalled() {
        sut.barButtonTapped()
        XCTAssertTrue(router.showCountryPickerCalled)
    }
    
    func test_calculatorScence_ratePickerTap_countryPickerCalled() {
        sut.selectedBodeBtnTap(UIButton())
        XCTAssertTrue(router.showCurrencyRatePickerCalled)
    }
    
    func test_calculatorScence_failureError_failureMessageShowCalled() {
        sut.showError(message: "")
        XCTAssertTrue(router.failureMessageShowCalled)
    }
}

private final class CalculatorInteractorSpy: CalculatorInteractorInput {
    var loadCurrentCountryCalled: Bool = false
    func loadCurrentCountry() {
        loadCurrentCountryCalled = true
    }
    
    var loadCurrentRateCalled: Bool = false
    func loadCurrentRate() {
        loadCurrentRateCalled = true
    }
    
    var loadRatesCalled: Bool = false
    func loadRates(reload: Bool) {
        loadRatesCalled = true
    }
    
    var convertCurrencyCalled: Bool = false
    func convertCurrency(value: Double) {
        convertCurrencyCalled = true
    }
    
}

private final class CalculatorRouterSpy: CalculatorRoutingLogic {
    var showCountryPickerCalled: Bool = false
    func showCountryPicker() {
        showCountryPickerCalled = true
    }
    
    var showCurrencyRatePickerCalled: Bool = false
    func showCurrencyRatePicker() {
        showCurrencyRatePickerCalled = true
    }
    
    var failureMessageShowCalled: Bool = false
    func showFailure(message: String) {
        failureMessageShowCalled = true
    }
}
