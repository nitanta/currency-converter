//
//  CountriesWorker.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/18/21.
//

import Foundation

protocol CountriesWorkerLogic {
    func fetchCountries(completion: @escaping (Result<[CountryResponse], Error>) -> Void)
}

class CountriesWorker: CountriesWorkerLogic {
    let countryManager: CountryManager
    init(manager: CountryManager) {
        self.countryManager = manager
    }
    
    func fetchCountries(completion: @escaping (Result<[CountryResponse], Error>) -> Void) {
        self.countryManager.loadCountries(completion: completion)
    }
}
