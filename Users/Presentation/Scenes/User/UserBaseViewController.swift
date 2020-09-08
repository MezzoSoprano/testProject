//
//  UserBaseViewController.swift
//  Users
//
//  Created by Svyatoslav Katola on 08.09.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit

class UserBaseViewController: UIViewController {
    
    lazy var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.style = .large
        activityIndicator.frame = view.frame
        view.addSubview(activityIndicator)
    }
    
    func configure(with error: Error) {
        presentAlert(with: error.localizedDescription)
    }
}
