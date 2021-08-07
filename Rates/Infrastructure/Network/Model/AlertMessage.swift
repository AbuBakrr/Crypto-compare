//
//  NetworkError.swift
//  Rates
//
//  Created by Abu-Bakr Jabbarov on 2/9/21.
//

import Foundation

struct AlertMessage: Error {
    var title = ""
    var body = ""
    
    init(title: String, body: String) {
        self.title = title
        self.body = body
    }
}
