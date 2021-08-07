//
//  CryptoCompareUseCase.swift
//  Rates
//
//  Created by Abu-Bakr Jabbarov on 8/7/21.
//

import Foundation

protocol CryptoCompareUseCase {
    func getConversionPrices(onComplete: @escaping (Swift.Result<[CryptoPrice], NetworkError>) -> Void)
    func getCryptos(onComplete: @escaping (Swift.Result<CryptosListResponse, NetworkError>) -> Void)
    func removeFromFavourites (cryptoName: String)
}

final class DefaultCryptoCompareUseCase {
    
    // MARK: - Properties
    
    private let api: CryptoCompareAPI
    private let favouritesStorage: FavouritesStorage
    
    // MARK: - Init
    
    init(api: CryptoCompareAPI = DefaultCryptoCompareAPI(),
         favouritesStorage: FavouritesStorage = DefaultFavouritesStorage()) {
        self.api = api
        self.favouritesStorage = favouritesStorage
    }
}

extension DefaultCryptoCompareUseCase: CryptoCompareUseCase {
    
    func getConversionPrices(onComplete: @escaping (Result<[CryptoPrice], NetworkError>) -> Void) {
        api.getConversionPrices(from: favouritesStorage.favoriteCryptocurrencyNames,
                                to: ["USD,EUR"]) { result in
            switch result {
            case .success(let response):
                
                let cryptoPrices = response.map { (name, cryptoPrice) -> CryptoPrice in
                    CryptoPrice(name: name, usd: cryptoPrice.usd, eur: cryptoPrice.eur)
                }
                onComplete(.success(cryptoPrices))
            case .failure(let error):
                onComplete(.failure(error))
            }
        }
    }
    
    func getCryptos(onComplete: @escaping (Result<CryptosListResponse, NetworkError>) -> Void) {
        api.getCryptos(key: ApiConst.APP_KEY, onComplete: onComplete)
    }
    
    func removeFromFavourites(cryptoName: String) {
        var mutablePrices = favouritesStorage.favoriteCryptocurrencyNames
        mutablePrices.removeAll(where: { $0 == cryptoName} )
        
        favouritesStorage.favoriteCryptocurrencyNames = mutablePrices
    }
}
