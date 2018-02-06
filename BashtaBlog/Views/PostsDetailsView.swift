//
//  PostView.swift
//  BashtaBlog
//
//  Created by Andrey Bashta on 1/31/18.
//  Copyright © 2018 Andrey Bashta. All rights reserved.
//

import Foundation

protocol PostsDetailsView {
    func appendMarks(marks: [MarkData]?)
    
    func appendComments(comments: [CommentData]?)
    func appendComment(comment: CommentData?)
}
