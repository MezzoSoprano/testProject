//
//  UsersPresenter.swift
//  Users
//
//  Created by Svyatoslav Katola on 08.09.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import Foundation

final class UsersPresenter {
    
    let service: UserService
    weak var view: UsersViewInput?
    weak var router: UsersRouterInput?
    
    init(service: UserService) {
        self.service = service
    }
}

extension UsersPresenter: UsersViewOutput {
    
    func select(user: User) {
        router?.presentUserDetails(user: user)
    }
    
    func updateData() {
        view?.configure(withLoading: true)
        
        service.users { [weak self] in
            switch $0 {
            case .success(let users):
                DispatchQueue.main.async { self?.view?.configure(with: users) }
            case .failure(let error):
                DispatchQueue.main.async { self?.view?.configure(with: error) }
            }
            
            DispatchQueue.main.async { self?.view?.configure(withLoading: false) }
        }
    }
}
