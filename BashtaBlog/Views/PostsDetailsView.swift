//
//  PostView.swift
//  BashtaBlog
//
//  Created by Andrey Bashta on 1/31/18.
//  Copyright © 2018 Andrey Bashta. All rights reserved.
//

import Foundation

protocol PostsDetailsView {
    
    func addMarks(marks: [MarkData]?)
    func getMarks()
    func getMarksByPostID(post: PostData?)
    
    func addComments(comments: [CommentData]?)
    func getComments()
    func getCommentsByPostID(post: PostData?)

}
