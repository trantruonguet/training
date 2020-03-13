//
//  Users.swift
//  GDStudio
//
//  Created by DatTH-GD on 3/11/20.
//  Copyright © 2020 DatTH-GD. All rights reserved.
//

import Foundation
import RealmSwift

class Users: Object {
    @objc dynamic var name = ""
    @objc dynamic var password = ""
    @objc dynamic var image: Data?
    
    
    override static func primaryKey() -> String? {
        return "name"
    }
}
