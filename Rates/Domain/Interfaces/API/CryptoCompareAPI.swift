//
//  CryptoCompareAPI.swift
//  Rates
//
//  Created by Abu-Bakr Jabbarov on 8/7/21.
//

import Foundation

protocol CryptoCompareAPI: AnyObject {
    
    func getConversionPrices(from currencies: [String],
                             to baseCurrencies: [String],
                             onComplete: @escaping (Swift.Result<CryptoPricesResponse, NetworkError>) -> Void)
    
    func getCryptos(key: String,
                    onComplete: @escaping (Swift.Result<CryptosListResponse, NetworkError>) -> Void)
}
