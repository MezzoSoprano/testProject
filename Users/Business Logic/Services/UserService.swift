//
//  UserService.swift
//  Users
//
//  Created by Svyatoslav Katola on 08.09.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import Foundation

typealias APIResult<T> = (Result<T, Error>) -> Void
typealias Users = [User]

protocol UserService {
    
    func users(completion: @escaping APIResult<Users>)
    func userDetails(userId: String, completion: @escaping APIResult<User.Details>)
    func updateUser(iserId: String, details: User.Details, completion: @escaping APIResult<Void>)
}
