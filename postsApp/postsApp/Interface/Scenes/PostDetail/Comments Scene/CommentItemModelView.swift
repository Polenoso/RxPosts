//
//  CommentItemModelView.swift
//  postsApp
//
//  Created by Aitor Pagán on 22/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation
import Infrastructure

struct CommentItemModelView {
    let body: String?
    let id: Int
    
    init(_ comment: Comment) {
        id = comment.id
        body = comment.body
    }
}
