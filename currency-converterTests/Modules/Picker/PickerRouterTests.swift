//
//  PickerRouterTests.swift
//  currency-converterTests
//
//  Created by Nitanta Adhikari on 6/20/21.
//

import XCTest
@testable import currency_converter

final class PickerRouterTests: XCTestCase {
    
    private var sut: PickerRouter!
    private var sceneFactory: SceneFactoryMock!
    private var source: SourceVCMock!
    private var navigationController: UINavigationControllerMock!
    
    override func setUp() {
        super.setUp()
        
        sceneFactory = SceneFactoryMock()
        source = SourceVCMock()
        navigationController = UINavigationControllerMock(rootViewController: source)
        sut = PickerRouter(sceneFactory: sceneFactory)
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
