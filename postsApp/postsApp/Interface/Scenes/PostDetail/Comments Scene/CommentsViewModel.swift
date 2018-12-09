//
//  CommentsViewModel.swift
//  postsApp
//
//  Created by Aitor Pagán on 22/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Infrastructure

protocol CommentsViewModel: class {
    var postId: PublishSubject<Int>? { get }
    func fetchComments(_ id: Int) -> Observable<[CommentItemModelView]>
}

class CommentsViewModelImpl: CommentsViewModel {
    
    let dataSource: CommentsUseCase
    weak var navigator: CommentsNavigator?
    var postId: PublishSubject<Int>?
    private var privateDataSource: BehaviorRelay<[CommentItemModelView]> = BehaviorRelay(value: [])
    private let disposeBag = DisposeBag()
    
    init(_ id: Int, nav: CommentsNavigator, source:CommentsUseCase) {
        navigator = nav
        dataSource = source
        postId = PublishSubject<Int>()
    }
    
    func fetchComments(_ id: Int) -> Observable<[CommentItemModelView]> {
        dataSource.comments(id).map{$0.map{CommentItemModelView($0)}}.bind { (items) in
            self.privateDataSource.accept(self.privateDataSource.value + items)
        }.disposed(by: disposeBag)
        return privateDataSource.asObservable()
    }
}
