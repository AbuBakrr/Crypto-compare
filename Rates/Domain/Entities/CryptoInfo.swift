//
//  Crypto.swift
//  Rates
//
//  Created by Abu-Bakr Jabbarov on 2/9/21.
//

import Foundation

struct CryptoInfo: Codable {
    let id: Int
    let symbol: String
    let partner_symbol: String
    let data_available_from: Int
}
