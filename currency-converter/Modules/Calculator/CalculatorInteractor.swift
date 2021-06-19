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
    func showDefaultCurrencyRate(code: String, rate: Double)
    func showLoader(show: Bool)
}

final class CalculatorInteractor {
    var presenter: CalculatorPresenterInput?
    var worker: PickerWorker?
}

extension CalculatorInteractor: CalculatorInteractorInput {
    func convertCurrency() {
        presenter?.showConvertedData(value: "100")
    }
    
    func loadRates() {
        presenter?.showLoader(show: true)
        worker?.fetchRates(completion: { [weak self] (result) in
            guard let self = self else { return }
            self.presenter?.showLoader(show: false)
            switch result {
            case .success(let lists):
                break
            case .failure(let error):
                self.presenter?.showFailure(message: error.localizedDescription)
            }
        })
    }
    
}
