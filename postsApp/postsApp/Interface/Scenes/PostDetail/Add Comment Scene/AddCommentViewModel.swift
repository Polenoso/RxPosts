//
//  AddCommentViewModel.swift
//  postsApp
//
//  Created by Aitor Pagán on 23/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Infrastructure
import NetworkProvider

protocol AddCommentViewModel: class {
    func saveComment(_ text: String?)
    func dismiss(_ vc: UIViewController)
    var isEnabled: Observable<Bool>? { get }
}

class AddCommentViewModelImpl: AddCommentViewModel {
    
    private let dataSource: CommentsUseCase?
    private let navigator: AddCommentNavigator
    var isEnabled: Observable<Bool>? = Observable<Bool>.just(false)
    
    init(dataSource: CommentsUseCase, navigator: AddCommentNavigator) {
        self.dataSource = dataSource
        self.navigator = navigator
    }
    
    func saveComment(_ text: String?) {
        _ = dataSource?.save(comment: Comment(with: text ?? "", id: 0, postId: 0))
    }
    
    func dismiss(_ vc: UIViewController) {
        navigator.dismiss(vc)
    }
}
