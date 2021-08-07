//
//  FavouritesStorage.swift
//  Rates
//
//  Created by Abu-Bakr Jabbarov on 8/7/21.
//

import Foundation

protocol FavouritesStorage: AnyObject {
    var favoriteCryptocurrencyNames: [String] { get set }
}
