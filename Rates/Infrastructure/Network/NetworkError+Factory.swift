//
//  NetworkError+Factory.swift
//  Rates
//
//  Created by Abu-Bakr Jabbarov on 8/7/21.
//

import Foundation

extension NetworkError {
    
    static func makeNoDataFoundError() -> NetworkError {
        return NetworkError(response: "", message: "No data found", hasWarning: false)
    }
    
    static func makeUnknownError() -> NetworkError {
        return NetworkError(response: "", message: "Unexpected error happened", hasWarning: false)
    }
}
