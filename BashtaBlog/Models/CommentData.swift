//
//  CommentData.swift
//  BashtaBlog
//
//  Created by Andrey Bashta on 2/1/18.
//  Copyright © 2018 Andrey Bashta. All rights reserved.
//

import Foundation
import Unbox

struct CommentData {
    
    let commentID: Int
    let text: String
    let datePublic: String
    let author: String
    
}

extension CommentData: Unboxable {
    init(unboxer: Unboxer) throws {
        self.commentID = try unboxer.unbox(key: "id")
        self.text = try unboxer.unbox(key: "text")
        self.datePublic = try unboxer.unbox(key: "datePublic")
        self.author = try unboxer.unbox(key: "author")
    }
}
