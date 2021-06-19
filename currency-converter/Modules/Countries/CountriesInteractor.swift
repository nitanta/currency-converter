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
    func showLoader(show: Bool)
}

final class CountriesInteractor {
    var presenter: CountriesPresenterInput?
    var worker: CountriesWorker?
    
    let database = CoreDataManager.shared
}

extension CountriesInteractor: CountriesInteractorInput {
    func selectCountry(code: String) {
        _ = CurrentCountry.saveCountryCode(code)
        database.saveContext()
        presenter?.goBack()
    }
    
    func loadCountries() {
        presenter?.showLoader(show: true)
        worker?.fetchCountries(completion: { [weak self] (result) in
            guard let self = self else { return }
            self.presenter?.showLoader(show: false)
            switch result {
            case .success(let lists):
                self.presenter?.showCountryList(list: lists)
            case .failure(let error):
                self.presenter?.showFailure(message: error.localizedDescription)
            }
        })
    }
    
}
