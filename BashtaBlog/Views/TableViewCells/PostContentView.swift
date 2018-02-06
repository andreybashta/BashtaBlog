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
    
    @IBOutlet weak var marksScrollView: UIScrollView!
    
    func configureCell(post: PostData) {
        postTitleLabel.text = post.title
        postTextLabel.text = post.text
        postDateLabel.text = post.datePublic
    }
    
    func setScrollSize(marks: [MarkData]) {
        marksScrollView.contentSize = CGSize(width: 100 * CGFloat(marks.count), height: marksScrollView.bounds.height)
    }
    
    func setScrollViewItems(marks: [MarkData]) {
        
        var currentX: CGFloat = -100
        
        for i in marks{
            
            let label = UILabel(frame: CGRect(x: currentX + 100, y: 0, width: 100, height: marksScrollView.bounds.height))
            label.text = i.name
            marksScrollView.addSubview(label)
            currentX += 100
        }
        
    }
    
}
