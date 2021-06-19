//
//  CalculatorRouter.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/18/21.
//

import UIKit

protocol CalculatorRoutingLogic {
    func showFailure(message: String)
    func showCountryPicker()
    func showCurrencyRatePicker()
}

final class CalculatorRouter {
    weak var source: UIViewController?
    private var sceneFactory: SceneFactory
    
    init(sceneFactory: SceneFactory) {
        self.sceneFactory = sceneFactory
    }
}

extension CalculatorRouter: CalculatorRoutingLogic {
    func showCountryPicker() {
        sceneFactory.countriesConfigurator = DefaultCountriesConfigurator(sceneFactory: sceneFactory)
        let scene = sceneFactory.makeCountryListScene()
        source?.navigationController?.present(scene, animated: true, completion: nil)
    }
    
    func showCurrencyRatePicker() {
        sceneFactory.pickerConfigurator = DefaultPickerConfigurator(sceneFactory: sceneFactory)
        let scene = sceneFactory.makeCurrencyRateListScene()
        source?.navigationController?.present(scene, animated: true, completion: nil)
    }
        
    func showFailure(message: String) {
        let action = UIAlertAction(title: "OK", style: .destructive)
        let alertController
            = UIAlertController(title: "Failure",
                                message: message,
                                preferredStyle: .alert)
        alertController.addAction(action)
        source?.present(alertController, animated: true)
    }
    
}
