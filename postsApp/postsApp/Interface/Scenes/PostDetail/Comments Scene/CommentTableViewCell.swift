//
//  CommentTableViewCell.swift
//  postsApp
//
//  Created by Aitor Pagán on 22/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    static let ReuseIdentifier = "CommentTableViewCell"

    @IBOutlet var commentBodyLabel: UILabel!
    
    func bind(_ comment: CommentItemModelView) {
        commentBodyLabel.text = comment.body
    }

}
