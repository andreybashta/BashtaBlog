//
//  PostPresenter.swift
//  BashtaBlog
//
//  Created by Andrey Bashta on 1/31/18.
//  Copyright © 2018 Andrey Bashta. All rights reserved.
//

import Foundation

class PostDetailsPresenter {
    
    private var postDetailsView: PostsDetailsView?
    private var post: PostData?
    
    func attachView(view: PostsDetailsView) {
        postDetailsView = view
    }
    
    func detachView() {
        postDetailsView = nil
    }
    
    public func loadData(forPost post: PostData?) {
        guard let post = post else {return}
        
        self.post = post

        self.getCommentsByPostID()
        self.getMarksByPostID()
    }
    
    func getMarksByPostID() {
        APIManager.sharedInstance.downloadMarksByPostID(post: post, completionHandler: { (marks) in
            self.postDetailsView?.appendMarks(marks: marks)
        })
    }
    
    func getCommentsByPostID() {
        APIManager.sharedInstance.downloadCommentsByPostID(post: post, completionHandler: { (comments) in
            self.postDetailsView?.appendComments(comments: comments)
        })
    }
    
    func addComment(_ comment: CommentData?) {
        APIManager.sharedInstance.uploadComment(post: post, comment: comment, completionHandler: { (comment) in
            self.postDetailsView?.appendComment(comment: comment)
        })
    }
    
}
