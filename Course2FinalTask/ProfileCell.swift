//
//  ProfileCell.swift
//  Course2FinalTask
//
//  Created by Polina on 23.02.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider


class ProfileCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImage.frame = CGRect(
            x: 0,
            y: 0,
            width: frame.width,
            height: frame.height
        )
    }
}





