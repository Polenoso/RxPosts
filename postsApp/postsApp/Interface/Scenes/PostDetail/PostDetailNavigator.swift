//
//  PostDetailNavigator.swift
//  postsApp
//
//  Created by Aitor Pagán on 22/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation
import UIKit
import NetworkProvider
import Infrastructure

protocol PostDetailNavigator: class {
    func presentPost(_ postItem:PostItemModelView)
    func presentComments(_ id: Int, vc: CommentsTableViewController)
    func presentAddComment(in vc: PostDetailViewController)
}

class PostDetailNavigatorDefault: PostDetailNavigator {
    let navigation: UINavigationController
    
    init( navigationController: UINavigationController) {
        navigation = navigationController
    }
    
    func presentPost(_ postItem:PostItemModelView) {
        let storyboard = UIStoryboard(name: "PostDetailScene", bundle: nil)
        let vc = storyboard.instantiateViewController(ofType: PostDetailViewController.self)
        vc.viewModel = PostDetailViewModelImpl(postItem, nav: self)
        navigation.pushViewController(vc, animated: true)
    }
    
    func presentComments(_ id: Int, vc: CommentsTableViewController) {
        let navigator = CommentsNavigatorDefault()
        navigator.presentComments(id, controller: vc)
    }
    
    func presentAddComment(in vc: PostDetailViewController) {
        let navigator = AddCommentNavigatorDefault()
        navigator.presentAdd(in: vc)
    }
    
}
