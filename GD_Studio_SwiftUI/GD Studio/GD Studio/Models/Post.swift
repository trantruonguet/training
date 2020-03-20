//
//  Post.swift
//  GD Studio
//
//  Created by PhucND-GD on 3/19/20.
//  Copyright © 2020 PhucND-GD. All rights reserved.
//

import RealmSwift

class Post: Object, Identifiable {
    
    
    
    @objc dynamic var id = Int.random(in: 0...1000)
    @objc dynamic var user: User!
    @objc dynamic var time: Double = 0
    @objc dynamic var location = ""
    @objc dynamic var content = ""
    @objc dynamic var image: Data?
}
