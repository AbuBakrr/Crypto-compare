//
//  DefaultCryptoCompareAPI.swift
//  Rates
//
//  Created by Abu-Bakr Jabbarov on 8/7/21.
//

import Foundation

final class DefaultCryptoCompareAPI {
    
    // MARK: - Properties
    
    private let networkManager: NetworkManager
    
    // MARK: - Init
    
    init(networkManager: NetworkManager = DefaultNetworkManager.shared) {
        self.networkManager = networkManager
    }
}

extension DefaultCryptoCompareAPI: CryptoCompareAPI {
    
    func getConversionPrices(from currencies: [String],
                             to baseCurrencies: [String],
                             onComplete: @escaping (Result<CryptoPricesResponse, NetworkError>) -> Void) {
        
        let params: [String : String] = [
            "fsyms" : currencies.joined(separator: ","),
            "tsyms" : baseCurrencies.joined(separator: ",")
        ]
        
        networkManager.call(endPoint: CryptoCompareEndPoint.prices, params: params) { (response: Swift.Result<CryptoPricesResponse, NetworkError>) in
            switch response {
            case .success(let response):
                onComplete(.success(response))
            case .failure(let error):
                onComplete(.failure(error))
            }
        }
    }
    
    func getCryptos(key: String, onComplete: @escaping (Result<CryptosListResponse, NetworkError>) -> Void) {
        
        let params: [String : String] = [
            "api_key" : key
        ]
        
        networkManager.call(endPoint: CryptoCompareEndPoint.list, params: params) { (response: Swift.Result<CryptosListResponse, NetworkError>) in
            switch response {
            case .success(let response):
                onComplete(.success(response))
            case .failure(let error):
                onComplete(.failure(error))
            }
        }
    }
}
