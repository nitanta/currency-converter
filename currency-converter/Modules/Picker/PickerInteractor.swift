//
//  PickerInteractor.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/18/21.
//

import Foundation

typealias PickerInteractorInput = PickerViewControllerOutput

protocol PickerInteractorOutput: AnyObject {
    func showLoader(show: Bool)
    func showRatesList(list: [String: Double])
    func showFailure(message: String)
    func goBack()
}

final class PickerInteractor {
    var presenter: PickerPresenterInput?
    var worker: PickerWorker?
    
    let database = CoreDataManager.shared
}

extension PickerInteractor: PickerInteractorInput {
    func loadRates() {
        showSavedRates()
        presenter?.showLoader(show: true)
        worker?.fetchRates(completion: { [weak self] (result) in
            guard let self = self else { return }
            self.presenter?.showLoader(show: false)
            switch result {
            case .success:
                self.showSavedRates()
            case .failure(let error):
                self.presenter?.showFailure(message: error.localizedDescription)
            }
        })
    }
    
    func selectRate(code: String, rate: Double) {
        let currentCode = getCurrentCode()
        _ = CurrentCurrency.saveCurrencyCode(code, source: currentCode, rate: rate)
        database.saveContext()
        presenter?.goBack()
    }
    
    private func showSavedRates() {
        let currentCode = getCurrentCode()
        if let rates = ExchangeRates.getRates(code: currentCode) {
            self.presenter?.showRatesList(list: rates.rates)
        }
    }
    
    private func getCurrentCode() -> String {
        guard let country = CurrentCountry.findCountrySaved() else {
            return Global.defaultCode
        }
        return country.code
    }
}
