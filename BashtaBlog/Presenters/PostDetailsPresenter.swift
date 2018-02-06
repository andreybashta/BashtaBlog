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
    
    func attachView(view: PostsDetailsView) {
        postDetailsView = view
    }
    
    func detachView() {
        postDetailsView = nil
    }
    
    func getMarksByPostID(post: PostData?) {
        APIManager.sharedInstance.downloadMarksByPostID(post: post, completionHandler: { (marks) in
            self.postDetailsView?.appendMarks(marks: marks)
        })
    }
    
    func getCommentsByPostID(post: PostData?) {
        APIManager.sharedInstance.downloadCommentsByPostID(post: post, completionHandler: { (comments) in
            self.postDetailsView?.appendComments(comments: comments)
        })
    }
    
    func setComment(post: PostData?, comment: CommentData?) {
        APIManager.sharedInstance.uploadComment(post: post, comment: comment)
        //TODO add completionHandler and comments refresh
    }
    
}
