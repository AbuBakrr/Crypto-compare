//
//  RootView.swift
//  Rates
//
//  Created by Abu-Bakr Jabbarov on 8/7/21.
//

import Foundation

protocol RootView: AnyObject {
    
    func configureView()
    
    func constructHierarchy()
    
    func activateConstraints()
    
    func wireActions()
    
    func configureContent()
    
    func setupBindings()
    
}

extension RootView {
    
    func configureView() {
        constructHierarchy()
        activateConstraints()
        wireActions()
        configureContent()
        setupBindings()
    }
    
    func setupBindings() {}
    
    func wireActions() {}
}

