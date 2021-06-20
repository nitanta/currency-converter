//
//  SceneDelegate.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/17/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var sceneFactory: DefaultSceneFactory!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        sceneFactory = DefaultSceneFactory()
        sceneFactory.calculatorConfigurator = DefaultCalculatorConfigurator(sceneFactory: sceneFactory)
        let navController = UINavigationController(rootViewController: sceneFactory.makeCalculatorScene())
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        CoreDataManager.shared.saveContext()
        (UIApplication.shared.delegate as! AppDelegate).scheduleBackgroundRateFetch()
    }


}

