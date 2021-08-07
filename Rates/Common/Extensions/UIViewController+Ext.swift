//
//  UIViewControllerExtensions.swift
//  Rates
//
//  Created by Abu-Bakr Jabbarov on 2/9/21.
//

import UIKit
import SVProgressHUD

extension UIViewController {
    
    func startLoading(string: String? = nil) {
        SVProgressHUD.show()
    }
    
    func stopLoading() {
        SVProgressHUD.dismiss()
    }

    func show(alert: AlertMessage) {
        let alertController = UIAlertController(title: alert.title, message: alert.body, preferredStyle: .alert)
        alertController.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
        alertController.view.tintColor = .black
        present(alertController, animated: true, completion: nil)
    }
}
