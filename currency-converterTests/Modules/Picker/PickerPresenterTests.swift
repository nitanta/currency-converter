//
//  PickerPresenterTests.swift
//  currency-converterTests
//
//  Created by Nitanta Adhikari on 6/20/21.
//

import XCTest
@testable import currency_converter

final class PickerPresenterTests: XCTestCase {
    
    var sut: PickerPresenter!
    var vc: PickerPresenterOutputMock!
        
    override func setUp() {
        super.setUp()
        
        sut = PickerPresenter()
        vc = PickerPresenterOutputMock()
        sut.viewController = vc
    }
    
    override func tearDown() {
        sut = nil
        vc = nil
        super.tearDown()
    }
    
    func test_pickerPresenter_showRateListCalled() {
        sut.showRatesList(list: [:])
        XCTAssertTrue(vc.showRateListCalled)
    }
    
    func test_pickerPresenter_showLoaderCalled() {
        sut.showLoader(show: true)
        XCTAssertTrue(vc.showLoaderCalled)
    }
    
    func test_pickerPresenter_goBackCalled() {
        sut.goBack()
        XCTAssertTrue(vc.goBackCalled)
    }
    
    func test_pickerPresenter_showErrorCalled() {
        sut.showFailure(message: "")
        XCTAssertTrue(vc.showErrorCalled)
    }
}

final class PickerPresenterOutputMock: PickerPresenterOutput {
    var showRateListCalled: Bool = false
    func showRateList(list: [String : Double]) {
        showRateListCalled = true
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
