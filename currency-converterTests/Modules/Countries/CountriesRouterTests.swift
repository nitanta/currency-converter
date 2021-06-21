//
//  CountriesRouterTest.swift
//  currency-converterTests
//
//  Created by Nitanta Adhikari on 6/20/21.
//

import XCTest
@testable import currency_converter

final class CountriesRouterTests: XCTestCase {
    
    private var sut: CountriesRouter!
    private var sceneFactory: SceneFactoryMock!
    private var source: SourceVCMock!
    private var navigationController: UINavigationControllerMock!
    
    override func setUp() {
        super.setUp()
        
        sceneFactory = SceneFactoryMock()
        source = SourceVCMock()
        navigationController = UINavigationControllerMock(rootViewController: source)
        sut = CountriesRouter(sceneFactory: sceneFactory)
        sut.source = source
    }
    
    override func tearDown() {
        sut = nil
        source = nil
        navigationController = nil
        source = nil
        
        super.tearDown()
    }
    
    func test_giveRouter_onSelectionSuccess_goBackCalled() {
        sut.goBack()
        XCTAssertTrue(source.dismissCalled)
    }
    
    func test_giveRouter_onFailure_thenPresentCalledOnSource() {
        sut.showFailure(message: "")
        XCTAssertTrue(source.presentCalled)
    }
}

final class SceneFactoryMock: SceneFactory {
    
    var countriesConfigurator: CountriesConfigurator!
    var pickerConfigurator: PickerConfigurator!
    var calculatorConfigurator: CalculatorConfigurator!
    
    func makeCountryListScene() -> UIViewController {
        return UIViewController()
    }
    
    func makeCurrencyRateListScene() -> UIViewController {
        return UIViewController()
    }
    
    func makeCalculatorScene() -> UIViewController {
        return UIViewController()
    }
}

final class UINavigationControllerMock: UINavigationController {
    var pushViewControllerCalled = false
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewControllerCalled = true
    }
}

final class SourceVCMock: UINavigationController {
    var presentCalled = false
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentCalled = true
    }
    
    var dismissCalled = false
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        dismissCalled = true
    }
}

