//
//  PickerWorker.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/18/21.
//

import Foundation
import Combine

class PickerWorker {
    
    private var bag = Set<AnyCancellable>()

    let database = CoreDataManager.shared
    let rateManager: RatesServiceProtocol
    init(manager: RatesServiceProtocol) {
        self.rateManager = manager
    }
    
    func fetchRates(forCountryCode: String, completion: @escaping (Result<[String: Double], Error>) -> Void) {
        self.rateManager.fetchRates(code: forCountryCode).sink { (error) in
            switch error {
            case .failure(let error):
                completion(.failure(APIProviderErrors.customError(error.localizedDescription)))
            case .finished: break
            }
        } receiveValue: { (response) in
            if response.success {
                guard let rates = response.quotes else {
                    completion(.failure(APIProviderErrors.dataNil))
                    return
                }
                _ = ExchangeRates.saveRates(response)
                self.database.saveContext()
                completion(.success(rates))
            } else {
                let errorMessage = response.errorMessage?.info
                completion(.failure(APIProviderErrors.customError(errorMessage.safeUnwrapped)))
            }
        }.store(in: &bag)

    }

}
