//
//  Post.swift
//  Infrastructure
//
//  Created by Aitor Pagán on 22/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation

public struct Post: Codable {
    public let userId: Int
    public let id: Int
    public let title: String
    public let body: String
    
    enum CodingKeys : String, CodingKey {
        case userId
        case id
        case title
        case body
    }
}
