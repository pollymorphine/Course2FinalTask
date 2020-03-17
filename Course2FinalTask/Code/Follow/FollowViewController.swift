//
//  FollowViewController.swift
//  Course2FinalTask
//
//  Created by Polina on 18.02.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider

final class FollowViewController: UITableViewController {
    
    public var users: [User]?
    public var navigationItemTitle: String?
    
    override func viewWillAppear(_ animated: Bool) {
        if let navigationItemTitleForFollowVC = navigationItemTitle {
            self.navigationItem.title = navigationItemTitleForFollowVC
        }
    }
    
    // MARK: UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "followCell", for: indexPath) as? FollowCell
            else { return UITableViewCell() }
        
        if let currentUser = users?[indexPath.row] {
            cell.userAvatar.image = currentUser.avatar
            cell.userName.text = currentUser.fullName
        }
        cell.delegate = self
        
        return cell
    }
    
    // MARK: - Functions
    
    func showProfile(cell: FollowCell) {
        if let currentUserCell = currentUserCell(cell: cell) {
            if let userProfile = DataProviders.shared.usersDataProvider.user(with: currentUserCell.id) {
                
                if let profile = storyboard?.instantiateViewController(withIdentifier:
                    "profileCollectionController") as? ProfileViewController {
                    profile.currentUser = userProfile
                    self.navigationController?.pushViewController(profile, animated: true)
                }
            }
        }
    }
    
   private func currentUserCell(cell: FollowCell) -> User? {
        if let indexPath = tableView.indexPath(for: cell) {
            
            if let currentUsers = users { return currentUsers[indexPath.row]}
        }
        return nil
    }
}
