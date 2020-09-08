//
//  UsersProtocols.swift
//  Users
//
//  Created by Svyatoslav Katola on 08.09.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import Foundation

protocol UsersViewInput: AnyObject {
    
    func configure(with: Users)
    func configure(withLoading: Bool)
    func configure(with: Error)
}

protocol UsersViewOutput {
    
    func updateData()
    func select(user: User)
}

protocol UsersRouterInput: AnyObject {
    
    func presentUserDetails(user: User)
}
