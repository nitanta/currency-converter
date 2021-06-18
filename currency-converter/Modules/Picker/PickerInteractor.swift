//
//  PickerInteractor.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/18/21.
//

import Foundation

typealias PickerInteractorInput = PickerViewControllerOutput

protocol PickerInteractorOutput: AnyObject {
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
        worker?.fetchRates(completion: { [weak self] (result) in
            guard let self = self else { return }
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
