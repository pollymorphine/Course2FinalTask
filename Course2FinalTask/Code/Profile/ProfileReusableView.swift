//
//  ProfileReusableView.swift
//  Course2FinalTask
//
//  Created by Polina on 23.02.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import  DataProvider

final class ProfileReusableView: UICollectionReusableView {
  
    @IBOutlet private var profileAvatar: UIImageView!
    @IBOutlet private var userName: UILabel!
    @IBOutlet private var followersLabel: UILabel!
    @IBOutlet private var followingLabel: UILabel!
    
    weak var delegate: ProfileViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileAvatar.layer.cornerRadius = profileAvatar.frame.width / 2
        profileAvatar.clipsToBounds = true
        
        addTapsGestureRecognizer()
    }
    
    func configure(with currentUser: User) {
        profileAvatar.image = currentUser.avatar
        userName.text = currentUser.fullName
        followersLabel.text = "Followers: \(currentUser.followedByCount)"
        followingLabel.text = "Following: \(currentUser.followsCount)"
    }
    
    @objc func tapToWatchFollowers() {
        delegate?.showFollowers()
    }
    
    @objc func tapToWatchFollowing() {
        delegate?.showFollowing()
    }
    
    func addTapsGestureRecognizer() {
        let tapFollowersLabel = UITapGestureRecognizer(target: self, action: #selector(tapToWatchFollowers))
        followersLabel.addGestureRecognizer(tapFollowersLabel)
        
        let tapFollowingLabel = UITapGestureRecognizer(target: self, action: #selector(tapToWatchFollowing))
        followingLabel.addGestureRecognizer(tapFollowingLabel)
    }
}
