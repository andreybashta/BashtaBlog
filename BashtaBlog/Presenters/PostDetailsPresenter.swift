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
    
    func getComments() {
        APIManager.sharedInstance.downloadComments(completionHandler: { (comments) in
            self.postDetailsView?.addComments(comments: comments)
        })
    }

}
