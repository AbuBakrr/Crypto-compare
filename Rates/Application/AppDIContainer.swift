//
//  AppDIContainer.swift
//  Rates
//
//  Created by Abu-Bakr Jabbarov on 8/7/21.
//

import Foundation


final class AppDIContainer {
    
    // MARK: - Network
    lazy var networkManager: NetworkManager = {
        let manager: NetworkManager = DefaultNetworkManager.shared
        return manager
    }()
}

extension AppDIContainer: AppFlowCoordinatorDependencies {
    
    func makeRatesListViewController(actions: RatesListViewModelActions) -> RatesListViewController {
        let viewModel = RatesListViewModel(actions: actions)
        let viewController = RatesListViewController(viewModel: viewModel)
        return viewController
    }
    
    func makeAddCryptoViewController() -> AddCryptoViewController {
        let viewController = AddCryptoViewController()
        return viewController
    }
}
