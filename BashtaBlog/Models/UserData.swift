//
//  UserData.swift
//  BashtaBlog
//
//  Created by Andrey Bashta on 2/5/18.
//  Copyright © 2018 Andrey Bashta. All rights reserved.
//

import Foundation
import Unbox

struct UserData {
    let name: String
    let password: String
}

extension UserData: Unboxable {
    init(unboxer: Unboxer) throws {
        self.name = try unboxer.unbox(key: "name")
        self.password = try unboxer.unbox(key: "password")
    }
}
