//
//  UIViewController.swift
//  Users
//
//  Created by Svyatoslav Katola on 08.09.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentAlert(with message: String) {
        let controller = UIAlertController(title: nil,
                                           message: message,
                                           preferredStyle: .alert)
        controller.addAction(.init(title: "OK", style: .cancel))
        present(controller, animated: true)
    }
}
