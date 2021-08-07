//
//  CryptoCompareEndPoint.swift
//  Rates
//
//  Created by Abu-Bakr Jabbarov on 8/7/21.
//

import Alamofire

enum CryptoCompareEndPoint {
    case list
    case prices
}

extension CryptoCompareEndPoint: EndPoint {
    
    var baseURL: String {
        return "https://min-api.cryptocompare.com/data/"
    }
    
    var path: String {
        switch self {
        case .list:
            return "blockchain/list"
        case .prices:
            return "pricemulti"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .list, .prices:
            return .post
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var urlString: String {
        switch self {
        default:
            return baseURL + path
        }
    }
}
