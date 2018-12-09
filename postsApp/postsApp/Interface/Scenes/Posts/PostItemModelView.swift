//
//  PostItemModelView.swift
//  postsApp
//
//  Created by Aitor Pagán on 22/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation
import Infrastructure

struct PostItemModelView {
    let title: String?
    let body: String?
    let id: Int
    
    init(_ post:Post) {
        id = post.id
        title = post.title
        body = post.body
    }
}
