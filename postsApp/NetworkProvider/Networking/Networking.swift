//
//  Networking.swift
//  NetworkProvider
//
//  Created by Aitor Pagán on 22/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation
import RxAlamofire
import Alamofire
import RxSwift
import RxCocoa

public enum RequestMethod: String {
    
    case get, post, put, patch
}

enum NetworkError : Error {
    case invalidRequest(String)
    case parsingError(String)
    case networkError(String)
}

public protocol Network: class {
    
    func request<T: Decodable>(with headers:([String: String]?), method:(RequestMethod), endPoint:(URL)) -> Observable<Result<[T]>>
    
}

public final class NetworkProvider: Network {
    public static let shared = NetworkProvider()
    private let scheduler: ConcurrentDispatchQueueScheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1))
    
    public func request<T: Decodable>(with headers: ([String : String]?), method: (RequestMethod), endPoint: (URL)) -> Observable<Result<[T]>> {
        guard let httpMethod = HTTPMethod(rawValue: method.rawValue.uppercased()) else {
            return Observable<Result<[T]>>.just(.failure(NetworkError.invalidRequest("Invalid Http Method")))
        }
        return RxAlamofire
            .data(httpMethod, endPoint, parameters: nil, encoding: URLEncoding.default, headers: headers)
            .debug()
            .observeOn(scheduler)
            .map({ data -> Result<[T]> in
                do {
                    let response = try JSONDecoder().decode([T].self, from: data)
                    return .success(response)
                } catch {
                    return .failure(error)
                }
            })
    }
    
}
