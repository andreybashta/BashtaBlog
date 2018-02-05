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
    
    func attachView(view: AuthorizeView) {
        authorizeView = view
    }
    
    func detachView() {
        authorizeView = nil
    }
    
    func loginUser() {
        APIManager.sharedInstance.doLogin()
    }
    
    func logoutUser() {
        APIManager.sharedInstance.doLogout()
    }
    
}
