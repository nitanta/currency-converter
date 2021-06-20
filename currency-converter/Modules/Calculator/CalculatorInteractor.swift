//
//  CalculatorInteractor.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/18/21.
//

import Foundation

typealias CalculatorInteractorInput = CalculatorViewControllerOutput

protocol CalculatorInteractorOutput: AnyObject {
    func showFailure(message: String)
    func showConvertedData(value: String)
    func showDefaultCountry(code: String)
    func showDefaultCurrencyRate(code: String, source: String, rate: Double)
    func showLoader(show: Bool)
}

final class CalculatorInteractor {
    var presenter: CalculatorPresenterInput?
    var worker: PickerWorker?
    
    let database = CoreDataManager.shared
}

extension CalculatorInteractor: CalculatorInteractorInput {
    func convertCurrency(value: Int) {
        if let currentRate = CurrentCurrency.findCurrencySaved() {
            let convertedValue = Double(value) * currentRate.rate
            self.presenter?.showConvertedData(value: String(format: "%.0f", convertedValue))
        }
    }
    
    func loadRates() {
        presenter?.showLoader(show: true)
        worker?.fetchRates(completion: { [weak self] (result) in
            guard let self = self else { return }
            self.presenter?.showLoader(show: false)
            switch result {
            case .success:
                if !CurrentCurrency.hasCurrencySaved() {
                    self.loadCurrentRate()
                }
            case .failure(let error):
                self.presenter?.showFailure(message: error.localizedDescription)
            }
        })
    }
    
    func loadCurrentCountry() {
        if CurrentCountry.hasCountrySaved(), let country = CurrentCountry.findCountrySaved() {
            presenter?.showDefaultCountry(code: country.code)
        } else {
            _ = CurrentCountry
                .saveCountryCode(Global.defaultCode)
            database.saveContext()
            presenter?.showDefaultCountry(code: Global.defaultCode)
        }
    }
    
    func loadCurrentRate() {
        let currentCode = self.getCurrentCode()
        if let currentSavedRate = CurrentCurrency.findCurrencySaved() {
            guard currentSavedRate.source == currentCode else { return }
            presenter?.showDefaultCurrencyRate(code: currentSavedRate.code, source: currentSavedRate.source, rate: currentSavedRate.rate)
        } else {
            guard let rates = ExchangeRates.getRates(code: currentCode), let firstRate = rates.rates.first else { return }
            _ = CurrentCurrency.saveCurrencyCode(firstRate.key, source: currentCode, rate: firstRate.value)
            database.saveContext()
            presenter?.showDefaultCurrencyRate(code: firstRate.key, source: currentCode, rate: firstRate.value)
        }
    }
    
    private func getCurrentCode() -> String {
        guard let country = CurrentCountry.findCountrySaved() else {
            return Global.defaultCode
        }
        return country.code
    }
    
}
