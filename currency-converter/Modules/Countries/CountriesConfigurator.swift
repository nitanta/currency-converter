//
//  CountriesConfigurator.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/18/21.
//

import Foundation

protocol CountriesConfigurator {
    func configured(_ vc: CountriesViewController) -> CountriesViewController
}

final class DefaultCountriesConfigurator: CountriesConfigurator {
    private var sceneFactory: SceneFactory
    
    init(sceneFactory: SceneFactory) {
        self.sceneFactory = sceneFactory
    }
    
    @discardableResult
    func configured(_ vc: CountriesViewController) -> CountriesViewController {
        
        sceneFactory.countriesConfigurator = self
        let worker = CountriesWorker(manager: CountryManager())
        let interactor = CountriesInteractor()
        let presenter = CountriesPresenter()
        let router = CountriesRouter(sceneFactory: sceneFactory)
        
        router.source = vc
        presenter.viewController = vc
        interactor.presenter = presenter
        interactor.worker = worker
        vc.output = interactor
        vc.router = router
        
        return vc
    }
}
