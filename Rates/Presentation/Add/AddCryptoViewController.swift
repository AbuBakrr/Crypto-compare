//
//  AddCryptoVC.swift
//  Rates
//
//  Created by Abu-Bakr Jabbarov on 2/9/21.
//

import UIKit

class AddCryptoViewController: NiblessViewController {
    
    // MARK: Properties
    var userInerface: AddCryptoUserInterfaceView?
    var router: (NSObjectProtocol & AddCryptoRoutingInterface)?
    var recentCurrencies: [String] = []
    let storage: FavouritesStorage = DefaultFavouritesStorage()
    
    let useCase: CryptoCompareUseCase = DefaultCryptoCompareUseCase()
    
    // MARK: Init
    override init() {
        
        super.init()
        
        // Setting up user interface
        userInerface = AddCryptoRootView()
        
        // Setting up router
        let router = AddCryptoRouter()
        router.viewController = self
        self.router = router
    }
    
    override func loadView() {
        view = userInerface
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        getAvailableCryptoCurrencies()
    }
    
    private func configureNavBar() {
        navigationController?.navigationBar.barTintColor = UIColor.white
        
        let sortButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(onSaveClicked))
        sortButton.tintColor = UIColor.black
        navigationItem.rightBarButtonItem = sortButton
    }
    
    @objc
    func onSaveClicked() {
        let symbols = userInerface?.getSelectedSymbols() ?? []
        storage.favoriteCryptocurrencyNames = symbols + storage.favoriteCryptocurrencyNames
        
        router?.routeBackToRatesListView()
    }
}

// MARK: - Network
extension AddCryptoViewController {
    
    private func getAvailableCryptoCurrencies() {
        startLoading()
        useCase.getCryptos { [weak self] result in
            guard let self = self else { return }
            self.stopLoading()
            switch result {
            case .success(let data):
                self.updateUserInterface(with: data)
            case .failure(let error):
                self.show(alert: AlertMessage(title: "Error", body: error.message))
            }
        }
    }
    
    private func updateUserInterface(with data: CryptosListResponse) {
        
        var selectedCryptos: [String : Bool] = [:]
        
        for symbol in storage.favoriteCryptocurrencyNames {
            selectedCryptos[symbol] = true
        }
        
        var cryptoInfo: [CryptoInfo] = []
        
        for ( _ , item) in data.data {
            if selectedCryptos[item.symbol] == nil {
                cryptoInfo.append(item)
            }
        }
        
        userInerface?.render(cryptoInfo: cryptoInfo)
    }
}
