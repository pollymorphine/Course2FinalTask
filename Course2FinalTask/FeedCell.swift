//
//  FeedCell.swift
//  Course2FinalTask
//
//  Created by Polina on 20.02.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider

class FeedCell: UITableViewCell {
    
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var bigLikeImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likesCount: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    weak var delegate: FeedViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userAvatar.isUserInteractionEnabled = true
        userName.isUserInteractionEnabled = true
        postDate.isUserInteractionEnabled = true
        likesCount.isUserInteractionEnabled = true
        bigLikeImage.isUserInteractionEnabled = true
        postImage.isUserInteractionEnabled = true
        
        
        addTapGestureRecognizer()
        userAvatar.addGestureRecognizer(addTapGestureRecognizerForUser())
        userName.addGestureRecognizer(addTapGestureRecognizerForUser())
        postDate.addGestureRecognizer(addTapGestureRecognizerForUser())
        
        bigLikeImage.alpha = 0.0
    }
    
    @IBAction func tapLikeButton(_ sender: UIButton) {
        delegate?.tapLikePostButton(cell: self)
    }
    
    @objc func tapToWatchProfile() {
        delegate?.showProfile(cell: self)
    }
    
    @objc func showBigLikeAnimation() {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [.curveLinear], animations: {
            self.bigLikeImage.alpha = 1.0
        }, completion: {_ in
            UIView.animate(withDuration: 0.3, delay: 0.2, options: [.curveEaseOut], animations: {
                self.bigLikeImage.alpha = 0
            }, completion: nil)
        })
        
        if likeButton.tintColor == UIColor.lightGray {
            delegate?.tapLikePostButton(cell: self)
        }
    }
    
    @objc func tapToWatchWhoLiked() {
        delegate?.showWhoLiked(cell: self)
    }
    
    func addTapGestureRecognizer() {
        let tapLikesCountLable = UITapGestureRecognizer(target: self, action: #selector(tapToWatchWhoLiked))
        likesCount.addGestureRecognizer(tapLikesCountLable)
        
        let tapBigLike = UITapGestureRecognizer(target: self, action: #selector(showBigLikeAnimation))
        tapBigLike.numberOfTapsRequired = 2
        postImage.addGestureRecognizer(tapBigLike)
    }
    
    func addTapGestureRecognizerForUser() -> UITapGestureRecognizer {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapToWatchProfile))
        return tapGestureRecognizer
    }
}


