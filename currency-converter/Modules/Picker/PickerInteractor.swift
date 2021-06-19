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
}

extension PickerInteractor: PickerInteractorInput {
    func loadRates() {
        presenter?.showLoader(show: true)
        worker?.fetchRates(completion: { [weak self] (result) in
            guard let self = self else { return }
            self.presenter?.showLoader(show: false)
            switch result {
            case .success(let lists):
                self.presenter?.showRatesList(list: lists)
            case .failure(let error):
                self.presenter?.showFailure(message: error.localizedDescription)
            }
        })
    }
    
    func selectRate(code: String, rate: Double) {
        //UserDefaults.standard.set(code, forKey: UserDefaultsKey.currencyCode)
        presenter?.goBack()
    }
    
}
