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
        sut.loadViewIfNeeded()
        
        interactor = CalculatorInteractorSpy()
        router = CalculatorRouterSpy()
        
        sut.output = interactor
        sut.router = router
    }
    
    override func tearDown() {
        sut = nil
        interactor = nil
        router = nil
        super.tearDown()
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
