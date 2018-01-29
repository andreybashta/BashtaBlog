//
//  BlogData.swift
//  BashtaBlog
//
//  Created by Andrey Bashta on 1/29/18.
//  Copyright © 2018 Andrey Bashta. All rights reserved.
//

import Foundation
import Unbox

struct PostData {
    
    let postID: Int
    let title: String
    let text: String
    let datePublic: String
    
}

extension PostData: Unboxable {
    init(unboxer: Unboxer) throws {
        self.postID = try unboxer.unbox(key: "id")
        self.title = try unboxer.unbox(key: "title")
        self.text = try unboxer.unbox(key: "text")
        self.datePublic = try unboxer.unbox(key: "datePublic")
    }
}
