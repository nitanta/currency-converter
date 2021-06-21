//
//  CalculatorRouterTests.swift
//  currency-converterTests
//
//  Created by Nitanta Adhikari on 6/20/21.
//

import XCTest
@testable import currency_converter

final class CalculatorRouterTests: XCTestCase {
    
    private var sut: CalculatorRouterMock!
    private var sceneFactory: SceneFactoryMock!
    private var source: SourceVCMock!
    private var navigationController: UINavigationControllerMock!
    
    override func setUp() {
        super.setUp()
        
        sceneFactory = SceneFactoryMock()
        source = SourceVCMock()
        navigationController = UINavigationControllerMock(rootViewController: source)
        sut = CalculatorRouterMock(sceneFactory: sceneFactory)
        sut.source = source
    }
    
    override func tearDown() {
        sut = nil
        source = nil
        navigationController = nil
        source = nil
        
        super.tearDown()
    }
    
    func test_giveRouter_onNavButtonTapped_thenPresentCalledOnSource() {
        sut.showCountryPicker()
        XCTAssertTrue(source.presentCalled)
    }
    
    func test_giveRouter_onPickerButtonTapped_thenPresentCalledOnSource() {
        sut.showCurrencyRatePicker()
        XCTAssertTrue(source.presentCalled)
    }
    
    func test_giveRouter_onFailure_thenPresentCalledOnSource() {
        sut.showFailure(message: "")
        XCTAssertTrue(source.presentCalled)
    }
}

final class CalculatorRouterMock: CalculatorRoutingLogic {
    weak var source: UIViewController?
    private var sceneFactory: SceneFactory
    
    init(sceneFactory: SceneFactory) {
        self.sceneFactory = sceneFactory
    }
    
    func showCountryPicker() {
        let scene = sceneFactory.makeCountryListScene()
        source?.present(scene, animated: true, completion: nil)
    }
    
    func showCurrencyRatePicker() {
        let scene = sceneFactory.makeCurrencyRateListScene()
        source?.present(scene, animated: true, completion: nil)
    }
        
    func showFailure(message: String) {
        source?.present(UIAlertController(title: nil, message: nil, preferredStyle: .alert), animated: true)
    }
}
