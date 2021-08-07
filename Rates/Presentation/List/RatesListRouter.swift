//
//  RatesListRouter.swift
//  Rates
//
//  Created by Abu-Bakr Jabbarov on 2/10/21.
//

import UIKit

protocol RatesListRoutingInterface {
    func routeToAddCryptoVC()
}

class RatesListRouter: NSObject, RatesListRoutingInterface {
    
    //MARK: - Properties
    weak var viewController: RatesListViewController?
    
    // MARK: Navigation
    func routeToAddCryptoVC() {
        let vc = AddCryptoViewController()
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
