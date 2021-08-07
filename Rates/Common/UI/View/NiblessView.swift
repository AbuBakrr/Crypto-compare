//
//  NiblessView.swift
//  Rates
//
//  Created by Abu-Bakr Jabbarov on 2/6/21.
//

import UIKit

open class NiblessView: UIView {
    
    // MARK: - Methods
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable,
    message: "Loading this view from a nib is unsupported"
    )
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Loading this view from a nib is unsupported")
    }
}
