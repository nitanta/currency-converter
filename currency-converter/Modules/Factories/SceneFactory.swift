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
}

final class DefaultSceneFactory: SceneFactory {
    var countriesConfigurator: CountriesConfigurator!
    var pickerConfigurator: PickerConfigurator!
}
