//
//  CommentsUseCase.swift
//  Infrastructure
//
//  Created by Aitor Pagán on 22/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation
import RxSwift


public protocol CommentsUseCase: UseCaseProtocol {
    func comments(_ id: Int) -> Observable<[Comment]>
    func save(comment: Comment) -> Observable<[Comment]>
}
