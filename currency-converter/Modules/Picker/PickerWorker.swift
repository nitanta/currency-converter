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

    let rateManager: RatesServiceProtocol
    init(manager: RatesServiceProtocol) {
        self.rateManager = manager
    }
    
    func fetchRates(completion: @escaping (Result<[String: Double], Error>) -> Void) {
        guard let code = UserDefaults.standard.string(forKey: UserDefaultsKey.currencyCode) else { return }
        self.rateManager.fetchRates(code: code).sink { (error) in
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
                completion(.success(rates))
            } else {
                let errorMessage = response.errorMessage?.info
                completion(.failure(APIProviderErrors.customError(errorMessage.safeUnwrapped)))
            }
        }.store(in: &bag)

    }

}
