//
//  FeedViewController.swift
//  Course2FinalTask
//
//  Created by Polina on 18.02.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider

final class FeedViewController: UITableViewController {
    
    public var post: [Post] = DataProviders.shared.postsDataProvider.feed()
    public var usersLikedPost = [User]()
    
    // MARK: UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as? FeedCell
            else { return UITableViewCell() }
        
        cell.configure(with: post[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    // MARK: Functions
    
    func showWhoLiked(cell: FeedCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            
            if let usersID = DataProviders.shared.postsDataProvider.usersLikedPost(with: post[indexPath.row].id) {
                usersLikedPost = usersID.compactMap{ currentUserID in
                    DataProviders.shared.usersDataProvider.user(with: currentUserID) }
                if usersLikedPost.isEmpty {
                    
                    if  let userLiked = storyboard?.instantiateViewController(withIdentifier: "followViewController") as? FollowViewController  {
                        userLiked.users = usersLikedPost
                        userLiked.navigationItem.title = "Likes"
                        self.navigationController?.pushViewController(userLiked, animated: true)
                    }
                }
            }
        }
    }
    
    func showProfile(cell: FeedCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            
            if let user = DataProviders.shared.usersDataProvider.user(with: post[indexPath.row].author) {
                
                if let profile = storyboard?.instantiateViewController(withIdentifier: "profileCollectionController") as? ProfileViewController {
                    profile.currentUser = user
                    self.navigationController?.pushViewController(profile, animated: true)
                }
            }
        }
    }
    
    func tapLikePostButton (cell: FeedCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            
            if cell.likeButton.tintColor == UIColor.lightGray {
                
                if DataProviders.shared.postsDataProvider.likePost(with: post[indexPath.row].id) {
                    post[indexPath.row].currentUserLikesThisPost = true
                    post[indexPath.row].likedByCount += 1
                    cell.likeButton.tintColor = .blue
                }
                
            } else if cell.likeButton.tintColor == UIColor.blue   {
                if DataProviders.shared.postsDataProvider.unlikePost(with: post[indexPath.row].id) {
                    post[indexPath.row].currentUserLikesThisPost = false
                    post[indexPath.row].likedByCount -= 1
                    cell.likeButton.tintColor = .lightGray
                }
            }
            self.tableView.reloadData()
       }
    }
}
