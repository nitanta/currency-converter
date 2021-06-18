//
//  PickerRouter.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/18/21.
//

import UIKit

protocol PickerRoutingLogic {
    func goBack()
    func showFailure(message: String)
}

final class PickerRouter {
    weak var source: UIViewController?
    private let sceneFactory: SceneFactory
    
    init(sceneFactory: SceneFactory) {
        self.sceneFactory = sceneFactory
    }
}

extension PickerRouter: PickerRoutingLogic {
    func goBack() {
        source?.dismiss(animated: true, completion: nil)
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
