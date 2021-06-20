//
//  PickerDbWorker.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/20/21.
//

import Foundation

class PickerDbWorker {
    
    let database = CoreDataManager.shared
    init() {}
    
    func getSavedRates() -> ExchangeRates? {
        let currentCode = getCurrentCode()
        let rates = ExchangeRates.getRates(code: currentCode)
        return rates
    }
    
    func getCurrentCode() -> String {
        guard let country = CurrentCountry.findCountrySaved() else {
            return Global.defaultCode
        }
        return country.code
    }
    
    func saveCurrentRate(code: String, rate: Double) {
        let currentCode = getCurrentCode()
        _ = CurrentCurrency.saveCurrencyCode(code, source: currentCode, rate: rate)
        database.saveContext()
    }
    
    func saveCountry(code: String) {
        _ = CurrentCountry.saveCountryCode(code)
        database.saveContext()
    }
    
    func loadSavedCountry() -> CurrentCountry {
        if CurrentCountry.hasCountrySaved(), let country = CurrentCountry.findCountrySaved() {
            return country
        } else {
            let country = CurrentCountry
                .saveCountryCode(Global.defaultCode)
            database.saveContext()
            return country
        }
    }
    
    func loadSavedRate() -> (code: String, source: String, rate: Double)? {
        let currentCode = self.getCurrentCode()
        if let currentSavedRate = CurrentCurrency.findCurrencySaved() {
            guard currentSavedRate.source == currentCode else { return nil }
            return (code: currentSavedRate.code, source: currentSavedRate.source, rate: currentSavedRate.rate)
        } else {
            return saveDefaultRate(currentCode: currentCode)
        }
    }
    
    func saveNewRate() -> (code: String, source: String, rate: Double)? {
        let currentCode = self.getCurrentCode()
        return saveDefaultRate(currentCode: currentCode)
    }
    
    func hasCurrentRateSaved() -> Bool {
        return CurrentCurrency.hasCurrencySaved()
    }
    
    private func saveDefaultRate(currentCode: String) -> (code: String, source: String, rate: Double)? {
        guard let rates = ExchangeRates.getRates(code: currentCode), let firstRate = rates.rates.first else { return nil }
        _ = CurrentCurrency.saveCurrencyCode(firstRate.key, source: currentCode, rate: firstRate.value)
        database.saveContext()
        return (code: firstRate.key, source: currentCode, rate: firstRate.value)
    }
}
