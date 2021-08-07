//
//  PricesResponse.swift
//  Rates
//
//  Created by Abu-Bakr Jabbarov on 2/9/21.
//

import Foundation

typealias CryptoPricesResponse =  [String: CryptoPrice]

struct CryptoPrice: Codable {
    var name: String = ""
    var usd: Double
    var eur: Double
    
    enum CodingKeys : String, CodingKey {
        case usd = "USD"
        case eur = "EUR"
    }
}
