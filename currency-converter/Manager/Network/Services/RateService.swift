//
//  ConversionService.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/18/21.
//

import Combine
import Foundation

protocol RatesServiceProtocol {
    func fetchRates(code: String) -> AnyPublisher<RatesResponse, Error>
}


class RatesService: RatesServiceProtocol {
    
    private let apiProvider = APIProvider<AppEndpoint>()
        
    init() {}
    
    func fetchRates(code: String) -> AnyPublisher<RatesResponse, Error> {
        return apiProvider.getData(
            from: .fetchRates(code: code)
        )
        .decode(type: RatesResponse.self, decoder: Container.jsonDecoder)
        .receive(on: RunLoop.main)
        .mapError({ error -> Error in
            return error
        })
        .map{
            return $0
        }
        .eraseToAnyPublisher()
    }
    
}

class MockRateService: RatesServiceProtocol {
    func fetchRates(code: String) -> AnyPublisher<RatesResponse, Error> {
        guard let response = RatesResponse.stubSuccessModel else {
            return Fail(error: APIProviderErrors.dataNil)
                .eraseToAnyPublisher()
        }
        return Just(response)
            .mapError{ _ in APIProviderErrors.unknownError}
            .eraseToAnyPublisher()
    }
    
}
