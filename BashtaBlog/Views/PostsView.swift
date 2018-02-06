//
//  PostView.swift
//  BashtaBlog
//
//  Created by Andrey Bashta on 1/31/18.
//  Copyright © 2018 Andrey Bashta. All rights reserved.
//

import Foundation

protocol PostsView {
    func appendPosts(posts: [PostData]?)
}
