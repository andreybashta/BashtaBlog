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
    let SECURITY = "/security"
    let LOGIN = "/login"
    let LOGOUT = "/logout"
    
    struct Static {
        static var instance: APIManager?
    }
    
    class var sharedInstance : APIManager {
        
        if(Static.instance == nil) {
            Static.instance = APIManager()
        }
        
        return Static.instance!
    }
    
    func downloadPosts(completionHandler: @escaping (_ posts: [PostData]?) -> Void) {
        Alamofire.request(APIManager.sharedInstance.BLOG_URL + POSTS, method: .get).responseData { response in
            
            switch response.result {
            case .success:
                let data = response.data
                if let posts: [PostData] = try? unbox(data: data!) {
                    completionHandler(posts)
                }
                debugPrint(response)
            case .failure:
                debugPrint(response)
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
                debugPrint(response)
            case .failure:
                debugPrint(response)
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
                debugPrint(response)
            case .failure:
                debugPrint(response)
            }
        }
    }
    
    func uploadComment(post: PostData?, comment: CommentData?, completionHandler: @escaping (_ comment: CommentData?) -> Void) {
        
        guard let comment = comment, let post = post else {
            print("COMMENT UPLOADING FAILED")
            return
        }
        
        let headers: HTTPHeaders = [
            "Accept": UserDefaults.standard.string(forKey: "session")!
        ]
        
        let parameters: Parameters = [
            "text": String(describing: comment.text),
            "idPost": String(describing: post.postID),
            "idUser": "191"
        ]
        
        Alamofire.request(APIManager.sharedInstance.BLOG_URL + COMMENTS, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseString { response in
            
            switch response.result {
            case .success:
                completionHandler(comment)
                debugPrint(response)
            case .failure:
                debugPrint(response)
            }
            
        }
        
    }
    
    func doLogin(username: String, password: String) {
        
        let headers: HTTPHeaders = [
            "Accept": "*/*"
        ]
        
        let parameters: Parameters = [
            "name": username,
            "password": password
        ]
        
        Alamofire.request(APIManager.sharedInstance.BLOG_URL + SECURITY + LOGIN, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseString { response in
            
            switch response.result {
            case .success:
                if let headerFields = response.response?.allHeaderFields as? [String: String], let URL = response.request?.url {
                    let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: URL)
                    UserDefaults.standard.set(String(describing: cookies), forKey: "session")
                }
                
                UserDefaults.standard.set(username, forKey: "username")
                UserDefaults.standard.set(password, forKey: "password")
                debugPrint(response)
                
            case .failure:
                debugPrint(response)
            }
            
        }
    }
    
    
    func doLogout() {
        Alamofire.request(APIManager.sharedInstance.BLOG_URL + SECURITY + LOGOUT, method: .get).responseString { response in
            
            switch response.result {
            case .success:
                UserDefaults.standard.removeObject(forKey: "session")
                UserDefaults.standard.removeObject(forKey: "username")
                UserDefaults.standard.removeObject(forKey: "password")
                debugPrint(response)
            case .failure:
                debugPrint(response)
            }

        }
    }

    
}
