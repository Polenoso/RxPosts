//
//  PostsTableViewController.swift
//  Interface
//
//  Created by Aitor Pagán on 22/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Infrastructure

class PostsTableViewController: UITableViewController {
    
    var viewModel: PostsViewModel?
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        bindViewModel()
    }
    
    private func configureTableView() {
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = nil;
        tableView.dataSource = nil;
    }
    
    private func bindViewModel() {
        viewModel?.fetch().bind(to: tableView.rx.items(cellIdentifier: PostTableViewCell.ReusableIdentifier, cellType: PostTableViewCell.self)) { (row, post, cell) in
            cell.bind(post)
        }.disposed(by: disposeBag)
        tableView
            .rx
            .modelSelected(PostItemModelView.self)
            .bind(to: (viewModel?.posts)!)
            .disposed(by: disposeBag)
    }

}
