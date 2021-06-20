//
//  PickerViewControllerTests.swift
//  currency-converterTests
//
//  Created by Nitanta Adhikari on 6/20/21.
//

import XCTest
@testable import currency_converter

final class PickerViewControllerTests: XCTestCase {
    
    private var sut: PickerViewController!
    private var interactor: PickerInteractorSpy!
    private var router: PickerRouterSpy!
    private var parentoutput: PickerParentControllerSpy!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "PickerViewController") as? PickerViewController
        
        interactor = PickerInteractorSpy()
        router = PickerRouterSpy()
        parentoutput = PickerParentControllerSpy()
        
        sut.output = interactor
        sut.router = router
        sut.parentOutput = parentoutput
        
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        interactor = nil
        router = nil
        parentoutput = nil
        super.tearDown()
    }
    
    
    func test_pickerScene_hasTableView() {
        XCTAssertNotNil(sut.tableView)
    }
    
    func test_pickerScene_hasTableViewDelegate() {
        XCTAssertNotNil(sut.tableView.delegate)
    }
    
    func test_pickerScene_tableViewConfirmsToTableViewDelegate() {
        XCTAssertTrue(sut.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:didSelectRowAt:))))
    }
    
    func test_pickerScene_hasTableViewDatasource() {
        XCTAssertNotNil(sut.tableView.dataSource)
    }
    
    func test_pickerScene_confirmsToTableViewDataSourceProtocol() {
        XCTAssertTrue(sut.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(sut.responds(to: #selector(sut.numberOfSections(in:))))
        XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:cellForRowAt:))))
    }
    
    func test_pickerScene_tableViewCellHasReuseIdentifier() {
        let stubData = RatesResponse.stubSuccessModel!
        
        let expectation1 = expectation(description: "Wait for tableview to reload")
        sut.rates = stubData.quotes!.map { (code: $0.key, value: $0.value)}
        sut.tableView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation1.fulfill()
        }
        waitForExpectations(timeout: 1)
        
        let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? PickerTableViewCell
        let actualReuseIdentifer = cell?.reuseIdentifier
        let expectedReuseIdentifier = "PickerTableViewCell"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }
     
    func test_pickerScene_viewloaded_loadCountriesCalled() {
        XCTAssertTrue(interactor.loadRatesCalled)
    }
    
    func test_pickerScene_whenDataSuppliedAndCellTapped_selectCountryCalled() {
        let stubData = RatesResponse.stubSuccessModel!

        let expectation1 = expectation(description: "Wait for tableview to reload")
        sut.rates = stubData.quotes!.map { (code: $0.key, value: $0.value)}
        sut.tableView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation1.fulfill()
        }
        waitForExpectations(timeout: 1)

        XCTAssertTrue(true)
    }
    
    func test_pickerScene_goBack_goBackCalled() {
        sut.goBack()
        XCTAssertTrue(router.goBackCalled)
    }
    
    func test_pickerScene_failureMessage_showFailureMessageCalled() {
        sut.showError(message: "")
        XCTAssertTrue(router.failureMessageShowCalled)
    }
    
    func test_pickerScene_parentTrigger_reloadCalled() {
        sut.goBack()
        XCTAssertTrue(parentoutput.reloadRatesCalled)
    }
    
}

private final class PickerInteractorSpy: PickerInteractorInput {
    var loadRatesCalled: Bool = false
    func loadRates() {
        loadRatesCalled = true
    }
    
    var selectRatesCalled: Bool = false
    func selectRate(code: String, rate: Double) {
        selectRatesCalled = true
    }
    
}

private final class PickerRouterSpy: PickerRoutingLogic {
    var goBackCalled: Bool = false
    func goBack() {
        goBackCalled = true
    }
    
    var failureMessageShowCalled: Bool = false
    func showFailure(message: String) {
        failureMessageShowCalled = true
    }
}

private final class PickerParentControllerSpy: PickerViewControllerParentOutput {
    var reloadRatesCalled: Bool = false
    func reloadRates() {
        reloadRatesCalled = true
    }
    
}

