//
//  UserCoordinator.swift
//  Users
//
//  Created by Svyatoslav Katola on 08.09.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit

final class UserSceneCoordinator {

    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
}

extension UserSceneCoordinator: Coordinator {
    
    func start() {
        let controller = UserSceneFactory.users(router: self)
        self.navigationController.viewControllers = [controller]
    }
}

extension UserSceneCoordinator: UsersRouterInput {
    
    func presentUserDetails(user: User) {
        let controller = UserSceneFactory.userDetails(user: user, router: self)
        navigationController.pushViewController(controller, animated: true)
    }
}

extension UserSceneCoordinator: UserDetailsRouterInput {
    
    func close() {
        navigationController.popViewController(animated: true)
    }
}

