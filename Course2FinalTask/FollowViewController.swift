//
//  FollowViewController.swift
//  Course2FinalTask
//
//  Created by Polina on 18.02.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider

class FollowViewController: UITableViewController {
    
    var user: [User]?
    var userId: User.Identifier!
    var navigationItemTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let _navigationItemTitle = navigationItemTitle {
            self.navigationItem.title = _navigationItemTitle
        }
    }

// MARK: UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "followCell", for: indexPath) as! FollowCell
        if let currentUser = user?[indexPath.row] {
            cell.userAvatar.image = currentUser.avatar
            cell.userName.text = currentUser.fullName
        }
        cell.delegate = self
        
        return cell
    }

// MARK: - Functions
    
    func showProfile(cell: FollowCell) {
        if let currentUserCell = currentUserCell(cell: cell)   {
            if let userProfile = DataProviders.shared.usersDataProvider.user(with: currentUserCell.id) {
                
                if let profile = storyboard?.instantiateViewController(withIdentifier:
                    "profileCollectionController") as? ProfileViewController {
                    profile.currentUser = userProfile
                    self.navigationController?.pushViewController(profile, animated: true)
                }
            }
        }
    }
    
    func currentUserCell(cell: FollowCell) -> User? {
        if let indexPath = tableView.indexPath(for: cell) {
            if let currentUsers = user { return currentUsers[indexPath.row]}
        }
        return nil
    }
}
