//
//  CountryManager.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/18/21.
//

import Foundation

class CountryManager {
    
    func loadCountries(completion: @escaping (Result<[CountryResponse], Error>) -> Void) {
        guard let path = Bundle.main.url(forResource: "Countries", withExtension: "json") else {
            completion(.failure(APIProviderErrors.unknownError))
            return
        }
        
        do {
            let data = try Data(contentsOf: path)
            let response = try Container.jsonDecoder.decode([CountryResponse].self, from: data)
            completion(.success(response))
        } catch {
            completion(.failure(APIProviderErrors.dataNil))
        }
        
    }
}
