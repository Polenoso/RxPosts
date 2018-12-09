//
//  CommentsTableViewController.swift
//  postsApp
//
//  Created by Aitor Pagán on 22/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Infrastructure

class CommentsTableViewController: UITableViewController {

    var viewModel: CommentsViewModel? {
        didSet {
            bindViewModel()
        }
    }
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = nil;
        tableView.dataSource = nil;
        tableView.tableFooterView = UIView()
    }
    
    private func bindViewModel() {
        let postIdObserve = viewModel?
            .postId?
            .asObserver()
            .subscribe(onNext: { (id) in
                self.viewModel?.fetchComments(id)
                    .bind(to: self.tableView.rx
                        .items(cellIdentifier: CommentTableViewCell.ReuseIdentifier, cellType: CommentTableViewCell.self))({ (row, comment, cell) in
                    cell.bind(comment)
                })
                    .disposed(by: self.disposeBag)
        })
        postIdObserve?.disposed(by: disposeBag)
        
    }


}
