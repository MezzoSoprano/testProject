//
//  UserDetailsProtocols.swift
//  Users
//
//  Created by Svyatoslav Katola on 08.09.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import Foundation

protocol UserDetailsViewInput: AnyObject {
    
    func configure(with userDetails: User.Details)
    func configure(withLoading: Bool)
    func configure(with: Error)
}

protocol UserDetailsViewOutput {
    
    func viewDidLoad()
    func save(userDetails: User.Details)
}

protocol UserDetailsRouterInput: AnyObject {
    
    func close()
}
