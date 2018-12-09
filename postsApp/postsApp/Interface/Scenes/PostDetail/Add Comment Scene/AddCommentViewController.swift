//
//  AddCommentViewController.swift
//  postsApp
//
//  Created by Aitor Pagán on 23/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AddCommentViewController: UIViewController {

    @IBOutlet var addButton: UIButton!
    @IBOutlet var commentTextView: UITextView!
    public var viewModel: AddCommentViewModel?
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
 
    @IBAction func dismiss(_ sender: Any) {
        viewModel?.dismiss(self)
    }
    private func bindViewModel() {
        let enabledButton = commentTextView.rx.text
        enabledButton.orEmpty.map{$0.count > 0}.share(replay: 1, scope: .whileConnected).bind(onNext: {self.addButton.isEnabled = $0}).disposed(by: disposeBag)
        
        let buttonAction = addButton.rx.tap
        
        buttonAction.bind { (_) in
            self.viewModel?.saveComment(self.commentTextView.text)
            self.viewModel?.dismiss(self)
        }.disposed(by: disposeBag)
    }

}
