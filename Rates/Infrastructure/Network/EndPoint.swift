//
//  EndPoint.swift
//  Rates
//
//  Created by Abu-Bakr Jabbarov on 2/9/21.
//

import Alamofire

protocol EndPoint {
    
    var baseURL: String { get }
    
    var path: String { get }
    
    var httpMethod: HTTPMethod { get }
    
    var headers: HTTPHeaders? { get }
    
    var urlString: String { get }
}

extension EndPoint {
    
    var urlString: String {
        return baseURL + path
    }
}


