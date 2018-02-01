//
//  MarkData.swift
//  BashtaBlog
//
//  Created by Andrey Bashta on 2/1/18.
//  Copyright © 2018 Andrey Bashta. All rights reserved.
//

import Foundation
import Unbox

struct MarkData {
    
    let markID: Int
    let name: String
    
}

extension MarkData: Unboxable {
    init(unboxer: Unboxer) throws {
        self.markID = try unboxer.unbox(key: "id")
        self.name = try unboxer.unbox(key: "name")
    }
}
