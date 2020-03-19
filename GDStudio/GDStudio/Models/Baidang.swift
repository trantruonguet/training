//
//  Baidang.swift
//  GDStudio
//
//  Created by AnhNT-GD on 3/19/20.
//  Copyright © 2020 DatTH-GD. All rights reserved.
//

import Foundation
import RealmSwift

class Baidang: Object {
     @objc dynamic var baidang = ""
       
       override static func primaryKey() -> String? {
           return "baidang"
       }
}
