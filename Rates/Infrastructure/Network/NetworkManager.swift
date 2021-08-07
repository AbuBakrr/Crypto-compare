//
//  Network.swift
//  Rates
//
//  Created by Abu-Bakr Jabbarov on 9/7/21.
//

import Alamofire

struct ApiConst {
    static let APP_KEY = "153d512364e6c29fa37a89c162723bebd5b9d50e65e5a6d87fdd5aec63e51656"
}

import UIKit
import Alamofire

protocol NetworkManager {
    
    typealias CompletionHandler<T> = (Swift.Result<T, NetworkError>) -> Void
    
    func call<T>(endPoint: EndPoint, params: Parameters?, encoding: ParameterEncoding, handler: @escaping CompletionHandler<T>) where T: Codable
}

extension NetworkManager {
    
    func call<T>(endPoint: EndPoint, params: Parameters? = nil, encoding: ParameterEncoding = JSONEncoding.default, handler: @escaping CompletionHandler<T>) where T: Codable {
        call(endPoint: endPoint, params: params, encoding: encoding, handler: handler)
    }
}

final class DefaultNetworkManager: NetworkManager {
    
    // MARK: - Singleton
    
    static let shared = DefaultNetworkManager()
    
    // MARK: - Init
    
    private init() {}
    
    func call<T>(endPoint: EndPoint, params: Parameters? = nil,encoding: ParameterEncoding = JSONEncoding.default, handler: @escaping CompletionHandler<T>) where T: Codable {
        
        AF.request(
            endPoint.urlString,
            method: endPoint.httpMethod,
            parameters: params,
            encoding: encoding,
            headers: endPoint.headers
        ).validate().responseJSON { (data) in
            do {
                guard let data = data.data else { throw NetworkError.makeNoDataFoundError() }
                let result = try JSONDecoder().decode(T.self, from: data)
                handler(.success(result))
            } catch {
                if let error = error as? NetworkError {
                    return handler(.failure(error))
                } else {
                    return handler(.failure(DefaultNetworkManager.parseApiError(data: data.data)))
                }
            }
        }
    }
    
    private static func parseApiError(data: Data?) -> NetworkError {
        guard let data = data else { return NetworkError.makeUnknownError() }

        if let error = try? JSONDecoder().decode(NetworkError.self, from: data) {
            return error
        } else {
            return NetworkError.makeUnknownError()
        }
    }
}

