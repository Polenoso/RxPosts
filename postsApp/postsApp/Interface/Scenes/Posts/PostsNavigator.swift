//
//  PostsNavigator.swift
//  postsApp
//
//  Created by Aitor Pagán on 22/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation
import UIKit
import NetworkProvider
import Infrastructure

protocol PostsNavigator: class {
    func presentPosts()
    func navigateToDetail(_ post: PostItemModelView)
}

class PostsNavigatorDefault: PostsNavigator {
    let navigation: UINavigationController
    
    init(navigationController: UINavigationController) {
        navigation = navigationController
    }
    
    func presentPosts() {
        let storyboard = UIStoryboard(name: "PostsScene", bundle: nil)
        let vc = storyboard.instantiateViewController(ofType: PostsTableViewController.self)
        vc.viewModel = PostsViewModelImpl(self, source: PostsNetworkDataSource(with: NetworkProvider.shared))
        navigation.pushViewController(vc, animated: true)
    }
    
    func navigateToDetail(_ post: PostItemModelView) {
        let postDetailNavigator = PostDetailNavigatorDefault(navigationController: self.navigation)
        postDetailNavigator.presentPost(post)
    }
    

}
