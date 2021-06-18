//
//  CountriesInteractor.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/18/21.
//

import Foundation

typealias CountriesInteractorInput = CountriesViewControllerOutput

protocol CountriesInteractorOutput: AnyObject {
    func showCountryList(list: [CountryResponse])
    func showFailure(message: String)
    func goBack()
}

final class CountriesInteractor {
    var presenter: CountriesPresenterInput?
    var worker: CountriesWorker?
}

extension CountriesInteractor: CountriesInteractorInput {
    func selectCountry(code: String) {
        UserDefaults.standard.set(code, forKey: UserDefaultsKey.currencyCode)
        presenter?.goBack()
    }
    
    func loadCountries() {
        worker?.fetchCountries(completion: { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let lists):
                self.presenter?.showCountryList(list: lists)
            case .failure(let error):
                self.presenter?.showFailure(message: error.localizedDescription)
            }
        })
    }
    
}
