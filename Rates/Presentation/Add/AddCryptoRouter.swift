//
//  AddCryptoRouter.swift
//  Rates
//
//  Created by Abu-Bakr Jabbarov on 2/9/21.
//

import UIKit

protocol AddCryptoRoutingInterface {
    func routeBackToRatesListView()
}

class AddCryptoRouter: NSObject, AddCryptoRoutingInterface {
    
    //MARK: - Properties
    weak var viewController: AddCryptoViewController?
    
    // MARK: Navigation
    func routeBackToRatesListView() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
