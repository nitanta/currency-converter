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
    var dbWorker: PickerDbWorker?
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
                guard let dbWorker = self.dbWorker else { return }
                if !dbWorker.hasCurrencySaved() {
                    self.loadCurrentRate()
                }
            case .failure(let error):
                self.presenter?.showFailure(message: error.localizedDescription)
            }
        })
    }
    
    func loadCurrentCountry() {
        guard let dbWorker = dbWorker else { return }
        
        let currentCountry = dbWorker.loadSavedCountry()
        presenter?.showDefaultCountry(code: currentCountry.code)
    }
    
    func loadCurrentRate() {
        guard let dbWorker = dbWorker else { return }
        
        if let rate = dbWorker.loadSavedRate() {
            presenter?.showDefaultCurrencyRate(code: rate.code, source: rate.source, rate: rate.rate)
        }
    }
    
}
