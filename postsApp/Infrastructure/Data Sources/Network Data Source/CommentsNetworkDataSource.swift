//
//  CommentsNetworkDataSource.swift
//  Infrastructure
//
//  Created by Aitor Pagán on 22/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import NetworkProvider
import Alamofire
import RxAlamofire

public final class CommentsNetworkDataSource : CommentsUseCase {
    
    let baseUrl = "https://jsonplaceholder.typicode.com/posts/%/comments"
    let network: Network
    private let disposeBag = DisposeBag()
    static var commentsCache: PublishSubject<[Comment]> = PublishSubject()
    
    public init(with network: Network) {
        self.network = network
    }
    
    public func comments(_ id: Int) -> Observable<[Comment]> {
        getComments(id)
            .subscribeOn(MainScheduler.instance)
            .map({ (result) -> [Comment] in
                switch result {
                case .success(let comments):
                    return comments
                case .failure(_):
                    return []
                }
            })
            .bind { (comments) in
                CommentsNetworkDataSource.commentsCache.on(Event<[Comment]>.next(comments))
            }.disposed(by: disposeBag)
        return CommentsNetworkDataSource.commentsCache
    }
    
    private func getComments(_ id: Int) -> Observable<Result<[Comment]>> {
        let path = baseUrl.replacingOccurrences(of: "%", with:"\(id)")
        guard let url = URL(string: path) else { return Observable.empty() }
        return network.request(with: nil, method: .get, endPoint: url)
    }
    
    public func save(comment: Comment) -> Observable<[Comment]> {
        CommentsNetworkDataSource.commentsCache.on(Event<[Comment]>.next([comment]))
        return Observable.just([comment])
    }
}
