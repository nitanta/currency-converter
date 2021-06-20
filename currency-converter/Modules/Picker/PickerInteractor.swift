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
    var dbWorker: PickerDbWorker?
}

extension PickerInteractor: PickerInteractorInput {
    
    func loadRates() {
        showSavedRates()
        
        guard let dbWorker = dbWorker else { return }
        presenter?.showLoader(show: true)
        
        let countryCode = dbWorker.getCurrentCode()
        worker?.fetchRates(forCountryCode: countryCode,completion: { [weak self] (result) in
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
        guard let dbWorker = dbWorker else { return }

        dbWorker.saveCurrentRate(code: code, rate: rate)
        presenter?.goBack()
    }
    
    private func showSavedRates() {
        guard let dbWorker = dbWorker else { return }
        
        if let rates = dbWorker.getSavedRates() {
            self.presenter?.showRatesList(list: rates.rates)
        }
    }
    
}
