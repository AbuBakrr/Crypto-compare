//
//  AppFlowCoordinator.swift
//  Rates
//
//  Created by Abu-Bakr Jabbarov on 8/7/21.
//

import UIKit

protocol AppFlowCoordinatorDependencies {
    func makeRatesListViewController(actions: RatesListViewModelActions) -> RatesListViewController
    func makeAddCryptoViewController() -> AddCryptoViewController
}

final class AppFlowCoordinator {
    
    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController,
         appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        let viewController = appDIContainer.makeRatesListViewController(actions: RatesListViewModelActions(routeToAddCryptoViewController: routeToAddCryptoViewController))
        self.navigationController.setViewControllers([viewController], animated: true)
    }
    
    func routeToAddCryptoViewController() {
        let viewController = appDIContainer.makeAddCryptoViewController()
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
