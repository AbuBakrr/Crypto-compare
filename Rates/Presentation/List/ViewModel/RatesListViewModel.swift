//
//  RatesListViewModel.swift
//  Rates
//
//  Created by Abu-Bakr Jabbarov on 8/7/21.
//

import RxCocoa

struct RatesListViewModelActions {
    let routeToAddCryptoViewController: () -> Void
}

final class RatesListViewModel: ViewModel {
    
    // MARK: - Dependencies
    
    let actions: RatesListViewModelActions
    let cryptoCompareUseCase: CryptoCompareUseCase
    
    // MARK: - Properties
    
    let prices = BehaviorRelay<[CryptoPrice]>(value: [])
    
    //MARK: - Init
    
    init(actions : RatesListViewModelActions,
         cryptoCompareUseCase: CryptoCompareUseCase = DefaultCryptoCompareUseCase()) {
        self.actions = actions
        self.cryptoCompareUseCase = cryptoCompareUseCase
        super.init()
    }
    
    @objc func didTapAddButton() {
        actions.routeToAddCryptoViewController()
    }
    
    func getPrices() {
        startLoading()
        cryptoCompareUseCase.getConversionPrices { [weak self] result in
            guard let self = self else { return }
            self.stopLoading()
            switch result {
            case .success(let prices):
                self.prices.accept(prices)
            case .failure(let error):
                self.error.onNext(error.message)
            }
        }
    }
    
    func removeItem(at index: Int) {
        cryptoCompareUseCase.removeFromFavourites(cryptoName: prices.value[index].name)
        var mutablePrices = prices.value
        mutablePrices.remove(at: index)
        
        prices.accept(mutablePrices)
    }
}
