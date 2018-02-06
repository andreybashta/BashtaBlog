//
//  AuthorizePresenter.swift
//  BashtaBlog
//
//  Created by Andrey Bashta on 2/5/18.
//  Copyright © 2018 Andrey Bashta. All rights reserved.
//

import Foundation

class AuthorizePresener {
    
    private var authorizeView: AuthorizeView?
    
    var username: String?
    var password: String?
    
    func attachView(view: AuthorizeView) {
        authorizeView = view
    }
    
    func detachView() {
        authorizeView = nil
    }
    
    func loginUser(username: String, password: String) {
        self.username = username
        self.password = password
        
        APIManager.sharedInstance.doLogin(username: self.username!, password: self.password!)
    }
    
    func logoutUser() {
        APIManager.sharedInstance.doLogout()
    }
    
}
