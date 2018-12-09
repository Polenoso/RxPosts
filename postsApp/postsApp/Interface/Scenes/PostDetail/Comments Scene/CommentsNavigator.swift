//
//  CommentsNavigator.swift
//  postsApp
//
//  Created by Aitor Pagán on 22/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation
import Infrastructure
import NetworkProvider

protocol CommentsNavigator: class {
    func presentComments(_ postId: Int, controller: CommentsTableViewController)
}

class CommentsNavigatorDefault: CommentsNavigator {
    
    func presentComments(_ postId: Int, controller: CommentsTableViewController) {
        let service = CommentsViewModelImpl(postId, nav: self, source: CommentsNetworkDataSource(with: NetworkProvider.shared))
        controller.viewModel = service;
        service.postId?.on(.next(postId))
    }
    
}
