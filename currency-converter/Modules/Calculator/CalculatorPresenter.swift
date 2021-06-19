//
//  CalculatorPresenter.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/18/21.
//

import UIKit

typealias CalculatorPresenterInput = CalculatorInteractorOutput
typealias CalculatorPresenterOutput = CalculatorViewControllerInput

final class CalculatorPresenter {
    weak var viewController: CalculatorPresenterOutput?
}

extension CalculatorPresenter: CalculatorPresenterInput {
    func showConvertedData(value: String) {
        viewController?.showConvertedValue(value: value)
    }
        
    func showFailure(message: String) {
        viewController?.showError(message: message)
    }
    
    func showDefaultCountry(code: String) {
        viewController?.showDefaultCountry(code: code)
    }
    
    func showDefaultCurrencyRate(code: String, source: String, rate: Double) {
        viewController?.showDefaultCurrencyRate(code: code, source: source, rate: 23.0)
    }
    
    func showLoader(show: Bool) {
        viewController?.showLoader(show: show)
    }
    
}
