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
    
    func getMarks() {
        APIManager.sharedInstance.downloadMarks(completionHandler: { (marks) in
            self.postDetailsView?.addMarks(marks: marks)
        })
    }
    
    func getMarksByPostID(post: PostData?) {
        APIManager.sharedInstance.downloadMarksByPostID(post: post, completionHandler: { (marks) in
            self.postDetailsView?.addMarks(marks: marks)
        })
    }

    func getComments() {
        APIManager.sharedInstance.downloadComments(completionHandler: { (comments) in
            self.postDetailsView?.addComments(comments: comments)
        })
    }
    
    func getCommentsByPostID(post: PostData?) {
        APIManager.sharedInstance.downloadCommentsByPostID(post: post, completionHandler: { (comments) in
            self.postDetailsView?.addComments(comments: comments)
        })
    }

}
