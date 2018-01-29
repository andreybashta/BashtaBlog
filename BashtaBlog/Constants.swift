//
//  Constants.swift
//  BashtaBlog
//
//  Created by Andrey Bashta on 1/29/18.
//  Copyright © 2018 Andrey Bashta. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
}

let BLOG_URL = "http://fed-blog.herokuapp.com/api"
let POSTS = "/v1/posts/"

typealias DownloadComplete = () -> ()
