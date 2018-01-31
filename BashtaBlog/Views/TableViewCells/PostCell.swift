//
//  TableViewCell.swift
//  BashtaBlog
//
//  Created by Andrey Bashta on 1/29/18.
//  Copyright © 2018 Andrey Bashta. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    
    func ConfigureCell(post: PostData) {
        postTitleLabel.text = post.title
        postTextLabel.text = post.text
        postDateLabel.text = post.datePublic
    }
    
}
