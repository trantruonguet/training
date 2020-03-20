//
//  User.swift
//  GD Studio
//
//  Created by PhucND-GD on 3/19/20.
//  Copyright © 2020 PhucND-GD. All rights reserved.
//

import RealmSwift

class User: Object {
    @objc dynamic var userName = ""
    @objc dynamic var password = ""
    @objc dynamic var avtar: Data?
    
    override class func primaryKey() -> String? {
        return "userName"
    }
}


