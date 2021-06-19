//
//  PickerPresenter.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/18/21.
//

import UIKit

typealias PickerPresenterInput = PickerInteractorOutput
typealias PickerPresenterOutput = PickerViewControllerInput

final class PickerPresenter {
    weak var viewController: PickerPresenterOutput?
}

extension PickerPresenter: PickerPresenterInput {
    func showLoader(show: Bool) {
        viewController?.showLoader(show: show)
    }
    
    func showRatesList(list: [String : Double]) {
        viewController?.showRateList(list: list)
    }
    
    func goBack() {
        viewController?.goBack()
    }
        
    func showFailure(message: String) {
        viewController?.showError(message: message)
    }
    
}
