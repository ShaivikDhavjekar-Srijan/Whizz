//
//  NetworkManager.swift
//  EYAssetManagement
//
//  Created by Kartik on 19/02/21.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    private let manager: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = nil
        configuration.timeoutIntervalForRequest = TimeInterval(90)
        configuration.timeoutIntervalForResource = TimeInterval(60)
        return Session(
            configuration: configuration)
    }()
    
    internal func performRequest<T: Codable>(serviceType:NetworkAPI, type:T.Type, completionHandler: @escaping(ApiResponse<T>)->()) {
        
        manager.request(serviceType.path,
                        method: serviceType.method,
                        parameters: serviceType.parameters,
                        encoding: serviceType.encoding,
                        headers: serviceType.headers).responseData { (response) in
            switch response.result {
            case .success(let value):
                do {
                    let model: T = try JSONDecoder().decode(type, from: value )
                    completionHandler(.success(value: model))
                } catch let error {
                    completionHandler(.failure(error: error))
                }
            case .failure(let error):
                print(error.localizedDescription)
                completionHandler(.failure(error: error))
            }
        }
        
    }
    
    internal func performRequestWithContinuation<T: Codable>(serviceType:NetworkAPI, type:T.Type) async throws -> T? {
        return try await withCheckedThrowingContinuation { continuation in
            manager.request(serviceType.path,
                            method: serviceType.method,
                            parameters: serviceType.parameters,
                            encoding: serviceType.encoding,
                            headers: serviceType.headers).responseData { (response) in
                switch response.result {
                case .success(let value):
                    do {
                        let model: T = try JSONDecoder().decode(type, from: value )
                        continuation.resume(returning:model)
                    } catch let error {
                        continuation.resume(throwing:error)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    continuation.resume(returning:nil)
                }
            }
            
        }
    }
}
