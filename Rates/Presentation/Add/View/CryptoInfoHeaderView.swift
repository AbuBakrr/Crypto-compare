//
//  CryptoInfoHeaderView.swift
//  Rates
//
//  Created by Abu-Bakr Jabbarov on 2/10/21.
//

import UIKit

class CryptoInfoHeaderView: NiblessView {
    
    // MARK: - Properties
    private var hierarchyNotReady = true
    
    // MARK: - Views
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.axis = .horizontal
        sv.spacing = 4
        return sv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Avenir.Black(size: 16).font
        label.textColor =  Colors.darkText
        label.textAlignment = .center
        label.text = "Name"
        return label
    }()
    
    let partnerNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Avenir.Black(size: 16).font
        label.textColor =  Colors.darkText
        label.textAlignment = .center
        label.text = "Partner's name"
        return label
    }()
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        guard hierarchyNotReady else {
            return
        }
        
        backgroundColor = Colors.background
        constrcutHierarchy()
        activateConstraints()
        
        hierarchyNotReady = false
    }
    
    private func constrcutHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(partnerNameLabel)
    }
    
    private func activateConstraints() {
        snapStackView()
    }
}

// MARK: - Layout
extension CryptoInfoHeaderView {
    
    private func snapStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let top = stackView.topAnchor.constraint(equalTo: topAnchor, constant: 0)
        let leading = stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)
        let trailing = stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        let bottom = stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        
        NSLayoutConstraint.activate([top, leading, trailing, bottom])
    }
    
}
