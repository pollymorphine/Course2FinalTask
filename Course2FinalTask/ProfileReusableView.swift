//
//  ProfileReusableView.swift
//  Course2FinalTask
//
//  Created by Polina on 23.02.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import  DataProvider

class ProfileReusableView: UICollectionReusableView {
    @IBOutlet weak var profileAvatar: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    weak var delegate: ProfileViewController?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileAvatar.isUserInteractionEnabled = true
        userName.isUserInteractionEnabled = true
        followersLabel.isUserInteractionEnabled = true
        followingLabel.isUserInteractionEnabled = true
        
        profileAvatar.layer.cornerRadius = profileAvatar.frame.width / 2
        profileAvatar.clipsToBounds = true
        
        addTapGestureRecognizer()
        
    }
    
    @objc func tapToWatchFollowers() {
        delegate?.showFollowers()
    }
    
    @objc func tapToWatchFollowing() {
        delegate?.showFollowing()
    }
    
    func addTapGestureRecognizer() {
        let tapFollowersLabel = UITapGestureRecognizer(target: self, action: #selector(tapToWatchFollowers))
        followersLabel.addGestureRecognizer(tapFollowersLabel)
        
        let tapFollowingLabel = UITapGestureRecognizer(target: self, action: #selector(tapToWatchFollowing))
        followingLabel.addGestureRecognizer(tapFollowingLabel)
    }
}
