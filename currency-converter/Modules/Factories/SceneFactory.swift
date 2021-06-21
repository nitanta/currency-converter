//
//  SceneFactory.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/18/21.
//

import UIKit

protocol SceneFactory {
    var countriesConfigurator: CountriesConfigurator! { get set }
    var pickerConfigurator: PickerConfigurator! { get set }
    var calculatorConfigurator: CalculatorConfigurator! { get set }
    func makeCountryListScene() -> UIViewController
    func makeCurrencyRateListScene() -> UIViewController
    func makeCalculatorScene() -> UIViewController
}

final class DefaultSceneFactory: SceneFactory {
    
    var countriesConfigurator: CountriesConfigurator!
    var pickerConfigurator: PickerConfigurator!
    var calculatorConfigurator: CalculatorConfigurator!
    
    func makeCountryListScene() -> UIViewController {
        let board = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        guard let viewController = board.instantiateViewController(identifier: "CountriesViewController") as? CountriesViewController else {
            fatalError()
        }
        return countriesConfigurator.configured(viewController)
    }
    
    func makeCurrencyRateListScene() -> UIViewController {
        let board = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        guard let viewController = board.instantiateViewController(identifier: "PickerViewController") as? PickerViewController else {
            fatalError()
        }
        return pickerConfigurator.configured(viewController)
    }
    
    func makeCalculatorScene() -> UIViewController {
        let board = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        guard let viewController = board.instantiateViewController(identifier: "CalculatorViewController") as? CalculatorViewController else {
            fatalError()
        }
        return calculatorConfigurator.configured(viewController)
    }

}
