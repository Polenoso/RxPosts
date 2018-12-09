//
//  PostsNetworkDataSource.swift
//  Infrastructure
//
//  Created by Aitor Pagán on 22/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation
import RxSwift
import NetworkProvider
import Alamofire
import RxAlamofire

public final class PostsNetworkDataSource : PostsUseCase {
    
    let baseUrl = "https://jsonplaceholder.typicode.com/posts"
    let network: Network
    
    public init(with network: Network) {
        self.network = network
    }
    
    public func posts() -> Observable<[Post]> {
        return getPosts()
            .subscribeOn(MainScheduler.instance)
            .map({ (result) -> [Post] in
                switch result {
                case .success(let posts):
                    return posts
                case .failure(_):
                    return []
                }
            })
    }
    
    private func getPosts() -> Observable<Result<[Post]>> {
        guard let url = URL(string: baseUrl) else { return Observable.empty() }
        return network.request(with: nil, method: .get, endPoint: url)
    }
    
    
}
