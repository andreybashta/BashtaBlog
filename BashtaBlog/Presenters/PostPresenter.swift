//
//  PostPresenter.swift
//  BashtaBlog
//
//  Created by Andrey Bashta on 1/31/18.
//  Copyright © 2018 Andrey Bashta. All rights reserved.
//

import Foundation

class PostPresenter {
    
    private var postView: PostsView?
    
    func attachView(view: PostsView) {
        postView = view
    }
    
    func detachView() {
        postView = nil
    }
    
    public func loadData() {
        getPosts()
    }
    
    public func logout() {
        APIManager.sharedInstance.doLogout()
    }
    
    private func getPosts() {
        APIManager.sharedInstance.downloadPosts(completionHandler: { (posts) in
            self.postView?.appendPosts(posts: posts)
        })
    }

}
