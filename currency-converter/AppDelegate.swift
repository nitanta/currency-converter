//
//  AppDelegate.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/17/21.
//

import UIKit
import BackgroundTasks

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        debugPrint(Utilities.getFilePath)
        Utilities.navigationBarCustomize()
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.lotuslabs.ratefetch", using: .main) { [weak self] (task) in
            guard let self = self else { return }
            self.handleAppRefreshTask(task: task as! BGAppRefreshTask)
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

}

extension AppDelegate {
    
    /// Handles background refresh
    /// - Parameter task: task for the background operation
    func handleAppRefreshTask(task: BGAppRefreshTask) {
        task.expirationHandler = {
            task.setTaskCompleted(success: false)
        }

        let rateWorkder = PickerWorker(manager: RatesService())
        let rateDbWorkder = PickerDbWorker()
        
        rateWorkder.fetchRates(forCountryCode: rateDbWorkder.getCurrentCountryCode()) { result in
            switch result {
            case .success(let rates):
                let countryCode = rateDbWorkder.getCurrentCountryCode()
                if let rateCode = rateDbWorkder.getCurrentCurrencyCode(), let updatedRate = rates[countryCode + rateCode]  {
                    rateDbWorkder.updateCurrentCurrencyRate(rate: updatedRate)
                }
            default: break
            }
            task.setTaskCompleted(success: true)
        }
        
        scheduleBackgroundRateFetch()
    }
    
    /// Schedule background tasks
    func scheduleBackgroundRateFetch() {
        let rateFetchTask = BGAppRefreshTaskRequest(identifier: "com.lotuslabs.ratefetch")
        rateFetchTask.earliestBeginDate = Date(timeIntervalSinceNow: 30 * 60) //30 minutes background refresh
        
        do {
          try BGTaskScheduler.shared.submit(rateFetchTask)
        } catch {
          print("Unable to submit task: \(error.localizedDescription)")
        }
    }
}
