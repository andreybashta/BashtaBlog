//
//  AuthorizeView.swift
//  BashtaBlog
//
//  Created by Andrey Bashta on 2/5/18.
//  Copyright © 2018 Andrey Bashta. All rights reserved.
//

import Foundation

protocol AuthorizeView {
    
    func loginUser(username: String, password: String)
    func logoutUser()
    
}

