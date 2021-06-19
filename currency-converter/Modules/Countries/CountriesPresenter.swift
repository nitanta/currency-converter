//
//  CountriesPresenter.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/18/21.
//

import UIKit

typealias CountriesPresenterInput = CountriesInteractorOutput
typealias CountriesPresenterOutput = CountriesViewControllerInput

final class CountriesPresenter {
    weak var viewController: CountriesPresenterOutput?
}

extension CountriesPresenter: CountriesPresenterInput {
    func showLoader(show: Bool) {
        viewController?.showLoader(show: show)
    }
    
    func goBack() {
        viewController?.goBack()
    }
    
    func showCountryList(list: [CountryResponse]) {
        viewController?.showCountriesList(list: list)
    }
    
    func showFailure(message: String) {
        viewController?.showError(message: message)
    }
    
}
