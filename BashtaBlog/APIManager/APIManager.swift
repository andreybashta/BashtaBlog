//
//  Constants.swift
//  BashtaBlog
//
//  Created by Andrey Bashta on 1/29/18.
//  Copyright © 2018 Andrey Bashta. All rights reserved.
//

import Foundation

typealias DownloadComplete = () -> ()

let BLOG_URL = "http://fed-blog.herokuapp.com/api"
let POSTS = "/v1/posts/"

public enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
}

public enum APIError: Error {
    case unauthorized
    case forbidden
    case unkownError
    case notFound
}

public func checkErrorCode(_ errorCode: Int) -> APIError {
    switch errorCode {
    case 401:
        return .unauthorized
    case 403:
        return .forbidden
    case 404:
        return .notFound
    default:
        return .unkownError
    }
}


