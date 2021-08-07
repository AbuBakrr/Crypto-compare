//
//  RatesListViewController.swift
//  Rates
//
//  Created by Abu-Bakr Jabbarov on 2/9/21.
//

import UIKit
import RxSwift

final class RatesListViewController: NiblessViewController {
    
    // MARK: Properties
        
    private let bag = DisposeBag()
    private let viewModel: RatesListViewModel

    // MARK: Init
    
    init(viewModel: RatesListViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - VIew lifecycle
    
    override func loadView() {
        view = RatesListRootView(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getPrices()
        setupBindings()
        configureNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !isBeingPresented && !isMovingToParent {
            viewModel.getPrices()
        }
    }
    
    private func configureNavBar() {
        navigationController?.navigationBar.barTintColor = UIColor.white

        let sortButton = UIBarButtonItem(title: "+", style: .plain, target: viewModel, action: #selector(viewModel.didTapAddButton))
        sortButton.tintColor = UIColor.black
        navigationItem.rightBarButtonItem = sortButton
    }
}

extension RatesListViewController {
    
    func setupBindings() {
        bindViewModelToLoader()
        bindError()
    }
    
    private func bindViewModelToLoader() {
        viewModel.isLoading
            .asObservable()
            .subscribe(
                onNext: { isLoading in
                    isLoading ? self.startLoading() : self.stopLoading()
                }
            ).disposed(by: bag)
    }
    
    private func bindError() {
        viewModel.error
            .asObservable()
            .subscribe(
                onNext: { error in
                    self.show(alert: AlertMessage(title: "Error", body: error))
                }
            ).disposed(by: bag)
    }
}
