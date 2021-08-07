//
//  AppDelegate.swift
//  Rates
//
//  Created by Abu-Bakr Jabbarov on 2/6/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    let appDIContainer = AppDIContainer()
    var appFlowCoordinator: AppFlowCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupInitialViewController()
        return true
    }
    
    private func setupInitialViewController() {
        configureWindow()
    }
    
    private func configureWindow() {
        
        let navController = UINavigationController()
        navController.navigationBar.isTranslucent = false
        navController.navigationBar.tintColor = Colors.navgationBarTint
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        
        appFlowCoordinator = AppFlowCoordinator(navigationController: navController,
                                                appDIContainer: appDIContainer)
        appFlowCoordinator?.start()
        window?.makeKeyAndVisible()
    }
}


