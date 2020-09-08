//
//  UsersViewController.swift
//  Users
//
//  Created by Svyatoslav Katola on 08.09.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit

final class UsersViewController: UserBaseViewController {
        
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        output.updateData()
        
        title = "Users"
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    var users: Users = []
    var output: UsersViewOutput!
    
    private let cellReuseIdentifier = "UserTableViewCell"
}

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.select(user: users[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
}

extension UsersViewController: UsersViewInput {
    
    @objc func refresh() {
        output.updateData()
    }
    
    func configure(with users: Users) {
        self.users = users
        tableView.reloadData()
    }
    
    func configure(withLoading flag: Bool) {
        flag ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        tableView.refreshControl?.endRefreshing()
    }
}
