//
//  AddCryptoRootView.swift
//  Rates
//
//  Created by Abu-Bakr Jabbarov on 2/9/21.
//

import UIKit

typealias AddCryptoUserInterfaceView = AddCryptoUserInterface & UIView

protocol AddCryptoUserInterface: class {
    func render(cryptoInfo: [CryptoInfo])
    func getSelectedSymbols() -> [String]
}

class AddCryptoRootView: NiblessView {
    
    // MARK: - Properties
    
    var cryptoInfo: [CryptoInfo] = []
    var filteredCryptoInfo: [CryptoInfo] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var hierarchyNotReady = true
    
    // MARK: - Views
    
    let loadingIndicator: UIActivityIndicatorView = {
        let iv = UIActivityIndicatorView()
        return iv
    }()
    
    lazy var searchView: UISearchBar = {
        let sb = UISearchBar()
        sb.tintColor = Colors.primary
        sb.textField?.textColor = Colors.darkText
        sb.textField?.font = UIFont.Avenir.Roman(size: 14).font
        sb.clearBackgroundColor()
        sb.delegate = self
        return sb
    }()
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.register(CryptoInfoCell.self, forCellReuseIdentifier: CryptoInfoCell.identifier)
        tv.dataSource = self
        tv.delegate = self
        tv.showsVerticalScrollIndicator = true
        tv.allowsMultipleSelection = true
        return tv
    }()
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        guard hierarchyNotReady else { return }
        
        backgroundColor = Colors.background
        constructHierarchy()
        activateFunctions()
        
        hierarchyNotReady = false
    }
    
    
    func constructHierarchy() {
        addSubview(searchView)
        addSubview(tableView)
    }
    
    func activateFunctions() {
        snapSearchBar()
        snapTableView()
    }
}

extension AddCryptoRootView: AddCryptoUserInterface {
    
    func render(cryptoInfo: [CryptoInfo]) {
        self.cryptoInfo = cryptoInfo
        self.filteredCryptoInfo = self.cryptoInfo
        
        tableView.reloadData()
    }
    
    func getSelectedSymbols() -> [String] {
        
        var symbols: [String] = []

        for indexPath in (tableView.indexPathsForSelectedRows ?? []) {
            symbols.append(filteredCryptoInfo[indexPath.row].symbol)
        }
        
        return symbols
    }
}

extension AddCryptoRootView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCryptoInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CryptoInfoCell.identifier, for: indexPath) as! CryptoInfoCell
        let info = filteredCryptoInfo[indexPath.row]
        cell.set(name: info.symbol, partnerName: info.partner_symbol)
        return cell
    }
}

extension AddCryptoRootView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 30, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0
        UIView.animate(withDuration: 0.7) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 52
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return CryptoInfoHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 52))
    }
}


// MARK: - Search

extension AddCryptoRootView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredCryptoInfo = cryptoInfo
        } else {
            filteredCryptoInfo = cryptoInfo.filter({ (item) -> Bool in
                item.symbol.starts(with: searchText)
            })
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchView.endEditing(true)
    }
}

// MARK: - Layout
extension AddCryptoRootView {
    
    func snapSearchBar() {
        searchView.translatesAutoresizingMaskIntoConstraints = false
        
        let top = searchView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12)
        let leading = searchView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16)
        let trailing = searchView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        
        NSLayoutConstraint.activate([top, leading, leading, trailing])
    }
    
    func snapTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let top = tableView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 12)
        let leading = tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
        let trailing = tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        let bottom = tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        
        NSLayoutConstraint.activate([top, leading, leading, trailing, bottom])
    }
}
