//
//  FeedViewController.swift
//  Course2FinalTask
//
//  Created by Polina on 18.02.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider

class FeedViewController: UITableViewController {
    
    var feed =  DataProviders.shared.postsDataProvider.feed()
    var post = [Post]()
    var user = [User]()
    var usersLikedPost = [User]()
    
// MARK: UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feed.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedCell
        
        let currentPost = feed[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "'Today at' hh:mm:ss a"
        let dateString = dateFormatter.string(from: currentPost.createdTime)
        
        cell.userAvatar.image = currentPost.authorAvatar
        cell.postDate.text = dateString
        cell.userName.text = currentPost.authorUsername
        cell.postImage.image = currentPost.image
        cell.likesCount.text = "Likes: \(currentPost.likedByCount)"
        cell.descriptionLabel.text  = currentPost.description
        cell.delegate = self
        
        if currentPost.currentUserLikesThisPost {
            cell.likeButton.tintColor = UIColor.blue
        } else {
            cell.likeButton.tintColor = UIColor.lightGray
        }
        
        return cell
    }
    
// MARK: Functions

    func showWhoLiked(cell: FeedCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            
            if let usersID = DataProviders.shared.postsDataProvider.usersLikedPost(with: feed[indexPath.row].id) {
                usersLikedPost = usersID.compactMap{ currentUserID in
                    DataProviders.shared.usersDataProvider.user(with: currentUserID) }
                if usersLikedPost.count > 0 {
                    
                    if  let userLiked = storyboard?.instantiateViewController(withIdentifier: "followViewController") as? FollowViewController  {
                        userLiked.user = usersLikedPost
                        userLiked.navigationItem.title = "Likes"
                        self.navigationController?.pushViewController(userLiked, animated: true)
                    }
                }
            }
        }
    }
    
    func showProfile(cell: FeedCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            
            if let user = DataProviders.shared.usersDataProvider.user(with: feed[indexPath.row].author) {
                
                if let profile = storyboard?.instantiateViewController(withIdentifier: "profileCollectionController") as? ProfileViewController {
                    profile.currentUser = user
                    self.navigationController?.pushViewController(profile, animated: true)
                }
            }
        }
    }
    
   func  tapLikePostButton (cell: FeedCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            
            if cell.likeButton.tintColor == UIColor.lightGray {
                
                if DataProviders.shared.postsDataProvider.likePost(with: feed[indexPath.row].id) {
                    feed[indexPath.row].currentUserLikesThisPost = true
                    feed[indexPath.row].likedByCount += 1
                    cell.likeButton.tintColor = .blue
                    self.tableView.reloadData()
                }
                
            } else if cell.likeButton.tintColor == UIColor.blue   {
                if DataProviders.shared.postsDataProvider.unlikePost(with: feed[indexPath.row].id) {
                    feed[indexPath.row].currentUserLikesThisPost = false
                    feed[indexPath.row].likedByCount -= 1
                    cell.likeButton.tintColor = .lightGray
                    self.tableView.reloadData()
                }
                
            } else {
            }
        }
    }
}
