//
//  UserDetailsPresenter.swift
//  Users
//
//  Created by Svyatoslav Katola on 08.09.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import Foundation

final class UserDetailsPresenter {
    
    let service: UserService
    let user: User
    
    weak var view: UserDetailsViewInput?
    weak var router: UserDetailsRouterInput?
    
    init(service: UserService,
         user: User) {
        self.service = service
        self.user = user
    }
}

extension UserDetailsPresenter: UserDetailsViewOutput {
    
    func viewDidLoad() {
        view?.configure(withLoading: true)
        
        service.userDetails(userId: user.id) { [weak self] in
            switch $0 {
            case .success(let userDetails):
                DispatchQueue.main.async { self?.view?.configure(with: userDetails) }
            case .failure(let error):
                DispatchQueue.main.async { self?.view?.configure(with: error) }
            }
            
            DispatchQueue.main.async { self?.view?.configure(withLoading: false) }
        }
    }
    
    func save(userDetails: User.Details) {
        view?.configure(withLoading: true)
        
        service.updateUser(iserId: user.id, details: userDetails) { [weak self] in
            switch $0 {
            case .success():
                DispatchQueue.main.async { self?.router?.close() }
            case .failure(let error):
                DispatchQueue.main.async { self?.view?.configure(with: error) }
            }
            
            DispatchQueue.main.async { self?.view?.configure(withLoading: false) }
        }
    }
}
