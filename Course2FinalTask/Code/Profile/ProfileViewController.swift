//
//  ProfileViewController.swift
//  Course2FinalTask
//
//  Created by Polina on 18.02.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider


final class  ProfileViewController: UICollectionViewController  {
    
    public var currentUser = DataProviders.shared.usersDataProvider.currentUser()
    public var posts: [Post]?
    
    private let reuseIdentifier = "profileCell"
    private let reuseHeaderIdentifier = "ProfileReusableView"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        posts = DataProviders.shared.postsDataProvider.findPosts(by: currentUser.id)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = currentUser.username
    }
}

// MARK: UICollectionViewDataSource

extension ProfileViewController  {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ProfileCell
            else { return UICollectionViewCell() }
        
        let currentPost = posts?[indexPath.row]
        cell.profileImage.image = currentPost?.image
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let kind = UICollectionView.elementKindSectionHeader
        
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseHeaderIdentifier, for: indexPath) as? ProfileReusableView
            else { return UICollectionReusableView() }
        
        headerView.configure(with: currentUser)
        headerView.delegate = self
        
        return headerView
    }
    
    // MARK: Functions
    
    func showFollowers() {
        if  let followers = DataProviders.shared.usersDataProvider.usersFollowingUser(with: currentUser.id) {
            
            if let follow = storyboard?.instantiateViewController(withIdentifier: "followViewController") as? FollowViewController {
                follow.users  = followers
                navigationController?.pushViewController(follow, animated: true)
                follow.navigationItemTitle = "Followers"
            }
        }
    }
    
    func showFollowing() {
        if  let followers = DataProviders.shared.usersDataProvider.usersFollowedByUser(with: currentUser.id) {
            
            if let follow = storyboard?.instantiateViewController(withIdentifier: "followViewController") as? FollowViewController {
                follow.users  = followers
                navigationController?.pushViewController(follow, animated: true)
                self.navigationItem.title = currentUser.username
                follow.navigationItemTitle = "Following"
            }
        }
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: collectionView.bounds.width / 3,
            height: collectionView.bounds.width / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 0, right: 0)
    }
}
