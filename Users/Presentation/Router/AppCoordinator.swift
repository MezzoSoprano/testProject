//
//  AppCoordinator.swift
//  Users
//
//  Created by Svyatoslav Katola on 07.09.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit
import Foundation

final class AppCoordinator {
    
    private let window: UIWindow
    private let navigationController: UINavigationController
    var starterCoordinator: Coordinator?
    
    init(window: UIWindow = UIWindow(),
         navigationController: UINavigationController = UINavigationController()) {
        self.window = window
        self.navigationController = navigationController
        setupWindow()
        setupStarterCoordinator()
    }
    
    private func setupWindow() {
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
    
    private func setupStarterCoordinator() {
        self.starterCoordinator = UserSceneCoordinator(navigationController: navigationController)
    }
}

extension AppCoordinator: Coordinator {
        
    func start() {
        self.starterCoordinator?.start()
    }
}
