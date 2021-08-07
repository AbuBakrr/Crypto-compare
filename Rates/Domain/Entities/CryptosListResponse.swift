//
//  CryptosListResponse.swift
//  Rates
//
//  Created by Abu-Bakr Jabbarov on 2/9/21.
//

import Foundation

struct CryptosListResponse: Codable {
    
    var response: String
    var message: String
    var hasWarning: Bool
    var type: Int
    var data: [String : CryptoInfo]
    
    enum CodingKeys : String, CodingKey {
        case response = "Response"
        case message = "Message"
        case hasWarning = "HasWarning"
        case type = "Type"
        case data = "Data"
    }
}
