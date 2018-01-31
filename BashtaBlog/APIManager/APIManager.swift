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

typealias DownloadComplete = () -> ()

class APIManager {
    
    let BLOG_URL = "http://fed-blog.herokuapp.com/api"
    let POSTS = "/v1/posts/"
    
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
                if let posts: [PostData]? = try? unbox(data: data!) {
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
    
}


