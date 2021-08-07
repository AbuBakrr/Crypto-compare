//
//  CryptoInfoCell.swift
//  Rates
//
//  Created by Abu-Bakr Jabbarov on 2/9/21.
//

import UIKit

class CryptoInfoCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier = "CryptoInfoCell"
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
        return label
    }()
    
    let partnerNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Avenir.Roman(size: 16).font
        label.textColor =  Colors.lightText
        label.textAlignment = .center
        return label
    }()
    
    
    func set(name: String, partnerName: String) {
        nameLabel.text = name
        partnerNameLabel.text = partnerName
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        guard hierarchyNotReady else {
            return
        }
        
        constrcutHierarchy()
        activateConstraints()
        
        hierarchyNotReady = false
    }
    
    private func constrcutHierarchy() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(partnerNameLabel)
    }
    
    private func activateConstraints() {
        snapStackView()
    }
}

// MARK: - Layout
extension CryptoInfoCell {
    
    private func snapStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let top = stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0)
        let leading = stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0)
        let trailing = stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0)
        let bottom = stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        
        NSLayoutConstraint.activate([top, leading, trailing, bottom])
    }
    
}
