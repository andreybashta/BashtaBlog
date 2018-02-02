//
//  PostTextCell.swift
//  BashtaBlog
//
//  Created by Andrey Bashta on 2/1/18.
//  Copyright © 2018 Andrey Bashta. All rights reserved.
//

import UIKit

class PostContentView: UIView {

    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    
    func ConfigureCell(post: PostData) {
        postTitleLabel.text = post.title
        postTextLabel.text = post.text
        postDateLabel.text = post.datePublic
    }
    
}
