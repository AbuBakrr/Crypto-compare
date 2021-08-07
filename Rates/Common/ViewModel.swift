//
//  ViewModel.swift
//  Rates
//
//  Created by Abu-Bakr Jabbarov on 8/7/21.
//

import RxSwift
import RxCocoa

open class ViewModel {
    
    // MARK: - Base properties
    
    let error: PublishSubject<String> = PublishSubject<String>()
    let isLoading: PublishSubject<Bool> = PublishSubject<Bool>()
    
    func startLoading() {
        self.isLoading.onNext(true)
    }
    
    func stopLoading() {
        self.isLoading.onNext(false)
    }
}
