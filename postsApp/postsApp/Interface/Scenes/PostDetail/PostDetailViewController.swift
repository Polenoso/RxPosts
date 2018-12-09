//
//  PostDetailViewController.swift
//  postsApp
//
//  Created by Aitor Pagán on 22/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PostDetailViewController: UIViewController {
    
    @IBOutlet var postTitleLabel: UILabel!
    @IBOutlet var postBodyLabel: UILabel!
    
    var viewModel: PostDetailViewModel?
    let disposeBag = DisposeBag()
    
    var commentsController: CommentsTableViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        connectContainers()
        setupNavigationBar()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel?.post?.asObservable().subscribe(onNext: {[unowned self] (postItem) in
            self.postTitleLabel.text = postItem.title
            self.postBodyLabel.text = postItem.body
            if let commentsChild = self.commentsController {
                self.viewModel?.connectChild(postItem.id, child: commentsChild)
            }
        }).disposed(by: disposeBag)
    }
    
    private func setupNavigationBar() {
        let addComment = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        addComment.rx.tap.asControlEvent().bind { (event) -> Void in
            self.viewModel?.presentAddComment(in: self)
        }.disposed(by: disposeBag)
        self.navigationItem.rightBarButtonItem = addComment
    }
    
    private func connectContainers() {
        commentsController = children.filter{$0.isKind(of: CommentsTableViewController.self)}.first as? CommentsTableViewController
    }

}
