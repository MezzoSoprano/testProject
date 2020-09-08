//
//  UserSceneFactory.swift
//  Users
//
//  Created by Svyatoslav Katola on 08.09.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit

struct UserSceneFactory {
    
    static func users(router: UsersRouterInput) -> UsersViewController {
        let controller = UsersViewController()
        let presenter = UsersPresenter(service: MockedUserServiceImpl())
        controller.output = presenter
        presenter.view = controller
        presenter.router = router
        return controller
    }
    
    static func userDetails(user: User, router: UserDetailsRouterInput) -> UserDetailsViewController {
        let controller = UserDetailsViewController()
        let presenter = UserDetailsPresenter(service: MockedUserServiceImpl(), user: user)
        presenter.view = controller
        presenter.router = router
        controller.output = presenter
        return controller
    }
}
