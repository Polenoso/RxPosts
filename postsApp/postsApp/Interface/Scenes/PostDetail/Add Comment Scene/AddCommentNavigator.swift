//
//  AddCommentNavigator.swift
//  postsApp
//
//  Created by Aitor Pagán on 23/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation
import UIKit
import NetworkProvider
import Infrastructure

protocol AddCommentNavigator: class {
    func presentAdd(in vc: UIViewController)
    func dismiss(_ vc: UIViewController)
}

class AddCommentNavigatorDefault : AddCommentNavigator {
    
    func presentAdd(in vc: UIViewController) {
        let storyboard = UIStoryboard(name: "PostDetailScene", bundle: nil)
        let addvc = storyboard.instantiateViewController(ofType: AddCommentViewController.self)
        addvc.viewModel = AddCommentViewModelImpl(dataSource: CommentsNetworkDataSource(with: NetworkProvider.shared), navigator: self)
        addvc.modalPresentationStyle = .overCurrentContext
        addvc.modalTransitionStyle = .coverVertical
        vc.present(addvc, animated: true, completion: nil)
    }
    
    func dismiss(_ vc: UIViewController) {
        vc.dismiss(animated: true, completion: nil)
    }
}
