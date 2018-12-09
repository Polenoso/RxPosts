//
//  PostDetailViewModel.swift
//  postsApp
//
//  Created by Aitor Pagán on 22/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Infrastructure
import NetworkProvider

protocol PostDetailViewModel {
    var post: BehaviorRelay<PostItemModelView>? { get set }
    func connectChild(_ id:Int, child: CommentsTableViewController)
    func presentAddComment(in vc: PostDetailViewController)
}

class PostDetailViewModelImpl: PostDetailViewModel {
    public var useCase: CommentsUseCase?
    var post: BehaviorRelay<PostItemModelView>?
    var navigator: PostDetailNavigator?
    
    init(_ postItem:PostItemModelView, nav: PostDetailNavigator) {
        navigator = nav
        post = BehaviorRelay<PostItemModelView>(value: postItem)
    }
    
    func connectChild(_ id: Int, child: CommentsTableViewController) {
        navigator?.presentComments(id, vc: child)
    }
    
    func presentAddComment(in vc: PostDetailViewController) {
        navigator?.presentAddComment(in: vc)
    }
}
