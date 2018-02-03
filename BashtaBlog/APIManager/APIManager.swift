//
//  Constants.swift
//  BashtaBlog
//
//  Created by Andrey Bashta on 1/29/18.
//  Copyright © 2018 Andrey Bashta. All rights reserved.
//

import Foundation
import Alamofire
import Unbox

class APIManager {
    
    let BLOG_URL = "http://fed-blog.herokuapp.com/api/v1"
    let POSTS = "/posts"
    let MARKS = "/marks"
    let COMMENTS = "/comments"
    
    struct Static {
        static var instance: APIManager?
    }
    
    class var sharedInstance : APIManager {
        
        if(Static.instance == nil) {
            Static.instance = APIManager()
        }
        
        return Static.instance!
    }
    
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
    
    func downloadPosts(completionHandler: @escaping (_ posts: [PostData]?) -> Void) {
        Alamofire.request(APIManager.sharedInstance.BLOG_URL + POSTS, method: .get).responseData { response in
            
            switch response.result {
            case .success:
                let data = response.data
                if let posts: [PostData] = try? unbox(data: data!) {
                    completionHandler(posts)
                }
                break
            case .failure:
                let error = self.checkErrorCode(response.response!.statusCode)
                print(error)
                break
            }
        }
    }
    
    func downloadMarks(completionHandler: @escaping (_ marks: [MarkData]?) -> Void) {
        Alamofire.request(APIManager.sharedInstance.BLOG_URL + MARKS, method: .get).responseData { response in
            
            switch response.result {
            case .success:
                let data = response.data
                if let marks: [MarkData] = try? unbox(data: data!) {
                    completionHandler(marks)
                }
                break
            case .failure:
                let error = self.checkErrorCode(response.response!.statusCode)
                print(error)
                break
            }
        }
    }
    
    func downloadComments(completionHandler: @escaping (_ comments: [CommentData]?) -> Void) {
        Alamofire.request(APIManager.sharedInstance.BLOG_URL + COMMENTS, method: .get).responseData { response in
            
            switch response.result {
            case .success:
                let data = response.data
                if let comments: [CommentData] = try? unbox(data: data!) {
                    completionHandler(comments)
                }
                break
            case .failure:
                let error = self.checkErrorCode(response.response!.statusCode)
                print(error)
                break
            }
        }
    }
    
    func downloadCommentsByPostID(post: PostData?, completionHandler: @escaping (_ comments: [CommentData]?) -> Void) {
        
        let POST_ID = "/\(String(describing: post!.postID))/"
        
        Alamofire.request(APIManager.sharedInstance.BLOG_URL + COMMENTS + POSTS + POST_ID, method: .get).responseData { response in
            
            switch response.result {
            case .success:
                let data = response.data
                if let comments: [CommentData] = try? unbox(data: data!) {
                    completionHandler(comments)
                }
                break
            case .failure:
                let error = self.checkErrorCode(response.response!.statusCode)
                print(error)
                break
            }
        }
        
    }
    
    func downloadMarksByPostID(post: PostData?, completionHandler: @escaping (_ marks: [MarkData]?) -> Void) {
        
        let POST_ID = "/\(String(describing: post!.postID))"
        
        Alamofire.request(APIManager.sharedInstance.BLOG_URL + POSTS + POST_ID + MARKS, method: .get).responseData { response in
            
            switch response.result {
            case .success:
                let data = response.data
                if let marks: [MarkData] = try? unbox(data: data!) {
                    completionHandler(marks)
                }
                break
            case .failure:
                let error = self.checkErrorCode(response.response!.statusCode)
                print(error)
                break
            }
        }
        
    }
    
}
