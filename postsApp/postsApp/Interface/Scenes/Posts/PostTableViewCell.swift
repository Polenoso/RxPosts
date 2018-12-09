//
//  PostTableViewCell.swift
//  Interface
//
//  Created by Aitor Pagán on 22/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class PostTableViewCell: UITableViewCell {
    
    static let ReusableIdentifier: String = "PostTableViewCell"

    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postBodyLabel: UILabel!
    
    func bind(_ postItem:PostItemModelView) {
        postTitleLabel.text = postItem.title
        postBodyLabel.text = postItem.body
    }

}
