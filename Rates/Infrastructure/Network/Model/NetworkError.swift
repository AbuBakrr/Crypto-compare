//
//  NetworkError.swift
//  Rates
//
//  Created by Abu-Bakr Jabbarov on 2/10/21.
//

import Foundation

struct NetworkError: Error, Codable {
    
    let response: String
    let message: String
    let hasWarning: Bool
    
    enum CodingKeys : String, CodingKey {
        case response = "Response"
        case message = "Message"
        case hasWarning = "HasWarning"
    }
}
