//
//  PickerConfigurator.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/18/21.
//

import Foundation

protocol PickerConfigurator {
    func configured(_ vc: PickerViewController) -> PickerViewController
}

final class DefaultPickerConfigurator: PickerConfigurator {
    private var sceneFactory: SceneFactory
    
    init(sceneFactory: SceneFactory) {
        self.sceneFactory = sceneFactory
    }
    
    @discardableResult
    func configured(_ vc: PickerViewController) -> PickerViewController {
        
        sceneFactory.pickerConfigurator = self
        let worker = PickerWorker(manager: RatesService())
        let interactor = PickerInteractor()
        let presenter = PickerPresenter()
        let router = PickerRouter(sceneFactory: sceneFactory)
        
        router.source = vc
        presenter.viewController = vc
        interactor.presenter = presenter
        interactor.worker = worker
        vc.output = interactor
        vc.router = router
        
        return vc
    }
}
