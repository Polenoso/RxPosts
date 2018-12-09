//
//  Comment.swift
//  Infrastructure
//
//  Created by Aitor Pagán on 22/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation

public struct Comment : Codable {
    public let postId: Int
    public let id: Int
    public let name: String
    public let email: String
    public let body: String
    
    enum CodingKeys: String, CodingKey {
        case postId
        case id
        case name
        case email
        case body
    }
}

public extension Comment {
    public init(with body: String, id:Int, postId: Int) {
        self.postId = postId
        self.id = id
        name = ""
        self.body = body
        email = ""
        
    }
}
