//
//  UISearchBarExtensions.swift
//  Rates
//
//  Created by Abu-Bakr Jabbarov on 2/10/21.
//

import UIKit

extension UISearchBar {
    
    public var textField: UITextField? {
        if #available(iOS 13, *) {
            return searchTextField
        }
        let subViews = subviews.flatMap { $0.subviews }
        guard let tf = (subViews.filter { $0 is UITextField }).first as? UITextField else {
            return nil
        }
        return tf
    }
    
    func clearBackgroundColor() {
        guard let UISearchBarBackground: AnyClass = NSClassFromString("UISearchBarBackground") else { return }
        
        for view in subviews {
            for subview in view.subviews where subview.isKind(of: UISearchBarBackground) {
                subview.alpha = 0
            }
        }
    }
}
