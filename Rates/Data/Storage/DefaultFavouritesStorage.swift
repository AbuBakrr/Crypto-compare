//
//  DefaultFavouritesStorage.swift
//  Rates
//
//  Created by Abu-Bakr Jabbarov on 8/7/21.
//

import Foundation

final class DefaultFavouritesStorage: FavouritesStorage {
    
    // MARK: - Dependencies
    
    private let storage: UserDefaults
    
    // MARK: - Init
    
    init(storage: UserDefaults = .standard) {
        self.storage = storage
    }
    
    var favoriteCryptocurrencyNames: [String] {
        get { storage.stringArray(forKey: "FAVORITES") ?? ["BTC"] }
        set { storage.setValue(newValue, forKey: "FAVORITES") }
    }

    func clear() {
        storage.removeObject(forKey: Keys.favourites.rawValue)
    }
    
    fileprivate enum Keys: String {
        case favourites = "KEY.FAVORITES"
    }
}
