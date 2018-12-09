//
//  PostsUseCase.swift
//  Infrastructure
//
//  Created by Aitor Pagán on 22/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation
import RxSwift


public protocol PostsUseCase: UseCaseProtocol {
    func posts() -> Observable<[Post]>
}
