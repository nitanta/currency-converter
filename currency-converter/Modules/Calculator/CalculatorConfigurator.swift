//
//  CalculatorConfigurator.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/18/21.
//

import Foundation

protocol CalculatorConfigurator {
    func configured(_ vc: CalculatorViewController) -> CalculatorViewController
}

final class DefaultCalculatorConfigurator: CalculatorConfigurator {
    private var sceneFactory: SceneFactory
    
    init(sceneFactory: SceneFactory) {
        self.sceneFactory = sceneFactory
    }
    
    @discardableResult
    func configured(_ vc: CalculatorViewController) -> CalculatorViewController {
        
        sceneFactory.calculatorConfigurator = self
        let worker = PickerWorker(manager: RatesService())
        let interactor = CalculatorInteractor()
        let presenter = CalculatorPresenter()
        let router = CalculatorRouter(sceneFactory: sceneFactory)
        
        router.source = vc
        presenter.viewController = vc
        interactor.presenter = presenter
        interactor.worker = worker
        vc.output = interactor
        vc.router = router
        
        return vc
    }
}
