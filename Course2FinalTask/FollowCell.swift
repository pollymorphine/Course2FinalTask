//
//  FollowCell.swift
//  Course2FinalTask
//
//  Created by Polina on 25.02.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider


class FollowCell: UITableViewCell {
    
    weak var delegate: FollowViewController?
    
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userAvatar.isUserInteractionEnabled = true
        userName.isUserInteractionEnabled = true
        
        addTapGestureRecognizer()
    }
    
    @objc func TapToShowProfile() {
        delegate?.showProfile(cell: self)
    }
    
    func addTapGestureRecognizer() {
        let tapUserAvatar = UITapGestureRecognizer(target: self, action: #selector(TapToShowProfile))
        userAvatar.addGestureRecognizer(tapUserAvatar)
        
        let tapUserName = UITapGestureRecognizer(target: self, action: #selector(TapToShowProfile))
        userName.addGestureRecognizer(tapUserName)
    }
}
