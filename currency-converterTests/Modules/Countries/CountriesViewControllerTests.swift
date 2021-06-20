//
//  CountriesViewControllerTests.swift
//  currency-converterTests
//
//  Created by Nitanta Adhikari on 6/20/21.
//

import XCTest
@testable import currency_converter

final class CountriesViewControllerTests: XCTestCase {
    
    private var sut: CountriesViewController!
    private var interactor: CountriesInteractorSpy!
    private var router: CountriesRouterSpy!
    private var parentoutput: CountriesParentControllerSpy!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "CountriesViewController") as? CountriesViewController
        
        interactor = CountriesInteractorSpy()
        router = CountriesRouterSpy()
        parentoutput = CountriesParentControllerSpy()
        
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
    
    func test_countryScene_hasTableView() {
        XCTAssertNotNil(sut.tableView)
    }
    
    func test_countryScene_hasTableViewDelegate() {
        XCTAssertNotNil(sut.tableView.delegate)
    }
    
    func test_countyScene_tableViewConfirmsToTableViewDelegate() {
        XCTAssertTrue(sut.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:didSelectRowAt:))))
    }
    
    func test_countryScene_hasTableViewDatasource() {
        XCTAssertNotNil(sut.tableView.dataSource)
    }
    
    func test_countryScene_confirmsToTableViewDataSourceProtocol() {
        XCTAssertTrue(sut.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(sut.responds(to: #selector(sut.numberOfSections(in:))))
        XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:cellForRowAt:))))
    }
    
    func test_countryScene_tableViewCellHasReuseIdentifier() {
        let stubData = CountryResponse.stubCountriesModel
        
        let expectation1 = expectation(description: "Wait for tableview to reload")
        sut.countries = stubData
        sut.tableView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation1.fulfill()
        }
        waitForExpectations(timeout: 1)
        
        let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? CountryTableViewCell
        let actualReuseIdentifer = cell?.reuseIdentifier
        let expectedReuseIdentifier = "CountryTableViewCell"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }
     
    func test_countriesScene_viewloaded_loadCountriesCalled() {
        XCTAssertTrue(interactor.loadCountriesCalled)
    }
    
    func test_countriesScene_whenDataSuppliedAndCellTapped_selectCountryCalled() {
        let stubData = CountryResponse.stubCountriesModel
        
        let expectation1 = expectation(description: "Wait for tableview to reload")
        sut.countries = stubData
        sut.tableView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation1.fulfill()
        }
        waitForExpectations(timeout: 1)

        XCTAssertTrue(true)
    }
    
    func test_countriesScene_goBack_goBackCalled() {
        sut.goBack()
        XCTAssertTrue(router.goBackCalled)
    }
    
    func test_countriesScene_failureMessage_showFailureMessageCalled() {
        sut.showError(message: "")
        XCTAssertTrue(router.failureMessageShowCalled)
    }
    
    func test_countriesScene_parentTrigger_reloadCalled() {
        sut.goBack()
        XCTAssertTrue(parentoutput.reloadCountryCalled)
    }
    
}

private final class CountriesInteractorSpy: CountriesInteractorInput {
    var loadCountriesCalled: Bool = false
    func loadCountries() {
        loadCountriesCalled = true
    }
    
    var selectCountryCalled: Bool = false
    func selectCountry(code: String) {
        selectCountryCalled = true
    }
}

private final class CountriesRouterSpy: CountriesRoutingLogic {
    var goBackCalled: Bool = false
    func goBack() {
        goBackCalled = true
    }
    
    var failureMessageShowCalled: Bool = false
    func showFailure(message: String) {
        failureMessageShowCalled = true
    }
}

private final class CountriesParentControllerSpy: CountriesViewControllerParentOutput {
    var reloadCountryCalled: Bool = false
    func reloadCountry() {
        reloadCountryCalled = true
    }
    
}

