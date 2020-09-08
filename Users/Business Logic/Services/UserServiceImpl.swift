//
//  UserServiceImpl.swift
//  Users
//
//  Created by Svyatoslav Katola on 08.09.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import Foundation

final class MockedUserServiceImpl {
    
    private var users: Users = [
        .init(id: "1", name: "Andriy"),
        .init(id: "2", name: "Jack"),
        .init(id: "3", name: "Roman"),
        .init(id: "4", name: "Ivan"),
        .init(id: "5", name: "Yura"),
        .init(id: "6", name: "Bohdana"),
        .init(id: "7", name: "Ivanna"),
        .init(id: "8", name: "Casya"),
        .init(id: "9", name: "Svyat")
    ]
}

extension MockedUserServiceImpl: UserService {
    
    func updateUser(iserId: String, details: User.Details, completion: @escaping APIResult<Void>) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
            completion(.success(()))
        }
    }
    
    func users(completion: @escaping APIResult<Users>) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) { [unowned self] in
            completion(.success(self.users))
        }
    }
    
    func userDetails(userId: String, completion: @escaping APIResult<User.Details>) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.users
                .first { $0.id == userId }
                .map { User.Details(firstName: $0.name, lastName: "Sparrow") }
                .map { completion(.success($0)) }
        }
    }
}
