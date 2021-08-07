//
//  AppFonts.swift
//  Rates
//
//  Created by Abu-Bakr Jabbarov on 2/9/21.
//

import UIKit

public extension UIFont {
    
    enum Avenir {
        
        case Medium(size: CGFloat)
        case Roman(size: CGFloat)
        case Black(size: CGFloat)
        
        var font: UIFont {
            switch self {
            case .Medium(let size):
                return UIFont(name: "Avenir-Medium", size: size)!
            case .Roman(let size):
                return UIFont(name: "Avenir-Roman", size: size)!
            case .Black(let size):
                return UIFont(name: "Avenir-Black", size: size)!
            }
        }
    }
}
