//
//  PostsViewModel.swift
//  Interface
//
//  Created by Aitor Pagán on 22/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Infrastructure
import NetworkProvider

protocol PostsViewModel: class {
    var posts: PublishSubject<PostItemModelView> { get }
    var navigator: PostsNavigator? { get set }
    func fetch() -> Observable<[PostItemModelView]>
}

class PostsViewModelImpl: PostsViewModel {
    private let dataSource: PostsUseCase
    private let disposeBag = DisposeBag()
    lazy var posts = PublishSubject<PostItemModelView>()
    weak var navigator: PostsNavigator?
    
    init(_ nav: PostsNavigator, source: PostsUseCase) {
        self.navigator = nav
        self.dataSource = source
        posts.asObservable().subscribe(onNext: {
            print($0)
            nav.navigateToDetail($0)
        }).disposed(by: disposeBag)
    }
    
    func fetch() -> Observable<[PostItemModelView]> {
        return dataSource.posts().map{$0.map{PostItemModelView($0)}}
    }
}
