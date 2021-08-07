//
//  RatesListRootVIew.swift
//  Rates
//
//  Created by Abu-Bakr Jabbarov on 2/6/21.
//

import UIKit
import RxSwift

class RatesListRootView: NiblessView {
    
    // MARK: - Properties
    
    private let bag = DisposeBag()
    private let viewModel: RatesListViewModel
    private var hierarchyNotReady = true
    private var cryptoPrices: [CryptoPrice] = []
    
    // MARK: - Init
    
    init(frame: CGRect = .zero, viewModel: RatesListViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
    }
    
    var isRefreshControlAnimating: Bool = false {
        didSet {
            isRefreshControlAnimating ? refresher.beginRefreshing() : refresher.endRefreshing()
        }
    }
    
    // MARK: - Views
    
    private let refresher: UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.attributedTitle = NSAttributedString(string: "Pull to refresh")
        return rc
    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.register(RateCell.self, forCellReuseIdentifier: RateCell.identifier)
        tv.dataSource = self
        tv.delegate = self
        tv.showsVerticalScrollIndicator = true
        return tv
    }()
        
    @objc private func onPulled() {
        viewModel.getPrices()
    }
}

extension RatesListRootView: RootView {
        
    override func didMoveToWindow() {
        super.didMoveToWindow()
        guard hierarchyNotReady else { return }
        configureView()
        hierarchyNotReady = false
    }

    func configureContent() {
        
    }
        
    func constructHierarchy() {
        addSubview(tableView)
        tableView.addSubview(refresher)
    }
    
    func activateConstraints() {
        snapTableView()
    }
    
    func wireActions() {
        refresher.addTarget(self, action: #selector(onPulled), for: .valueChanged)
    }
    
    func setupBindings() {
        bindPricesToVIewModel()
        bindIsLoadingToRefreshControl()
    }
}

extension RatesListRootView {
    
    private func bindPricesToVIewModel() {
        viewModel.prices
            .asObservable()
            .subscribe(onNext: { prices in
                self.cryptoPrices = prices
                self.tableView.reloadData()
            })
            .disposed(by: bag)
    }
    
    private func bindIsLoadingToRefreshControl() {
        viewModel.isLoading
            .asObservable()
            .subscribe(onNext: { isLoading in
                if !isLoading {
                    self.isRefreshControlAnimating = false
                }
            })
            .disposed(by: bag)
    }
}

extension RatesListRootView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoPrices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RateCell.identifier, for: indexPath) as! RateCell
        let price = cryptoPrices[indexPath.row]
        cell.set(name: price.name, usdRate: price.usd, euroRate: price.eur)
        return cell
    }
}

extension RatesListRootView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0
        UIView.animate(withDuration: 0.7) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if indexPath.section == 0 {
            let remove = UITableViewRowAction(style: .normal, title: "Remove") { (action, indexPath) in
                self.removeRateFromFavorites(indexPath: indexPath)
            }
            remove.backgroundColor = .red
            return [remove]
        } else {
            return nil
        }
    }
    
    func removeRateFromFavorites(indexPath: IndexPath) {
        viewModel.removeItem(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 52
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        PriceHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 52))
    }

}

// MARK: - Layout
extension RatesListRootView {
    
    func snapTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let top = tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
        let leading = tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
        let trailing = tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        let bottom = tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        
        NSLayoutConstraint.activate([top, leading, leading, trailing, bottom])
    }
}
