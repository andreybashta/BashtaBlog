//
//  PostCommentCell.swift
//  BashtaBlog
//
//  Created by Andrey Bashta on 2/1/18.
//  Copyright © 2018 Andrey Bashta. All rights reserved.
//

import UIKit

class PostCommentsCell: UITableViewCell {

    @IBOutlet weak var commentTextLabel: UILabel!
    @IBOutlet weak var commentAuthorLabel: UILabel!
    @IBOutlet weak var commentDateLabel: UILabel!
    
    func сonfigureCell(comment: CommentData) {
        commentTextLabel.text = comment.text
        commentAuthorLabel.text = comment.author
        commentDateLabel.text = comment.datePublic
    }
    
}
