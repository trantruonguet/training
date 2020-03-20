//
//  RealmDBManager.swift
//  GD Studio
//
//  Created by PhucND-GD on 3/19/20.
//  Copyright © 2020 PhucND-GD. All rights reserved.
//

import RealmSwift


struct RealmDBManager {
    
    static let shared = RealmDBManager()
    
    var mainRealm: Realm {
        var config = Realm.Configuration.defaultConfiguration
        print(config.fileURL)
        config.schemaVersion = 1
        return try! Realm(configuration: config)
    }    
    
}

//MARK: Users
extension RealmDBManager {
    
    func isUserExist(username: String) -> User? {
        return mainRealm.object(ofType: User.self, forPrimaryKey: username)
    }
    
    func insertUser(username: String, passwrod: String, iamge: Data) {
        let user = User()
        user.userName = username
        user.password = passwrod
        user.avtar = iamge
        try? mainRealm.write {
            self.mainRealm.add(user, update: .all)
        }
    }
    
    func insertPost(content: String, image: Data, location: String, user: User) {
        let post = Post()
        post.content = content
        post.image = image
        post.time = Date().timeIntervalSince1970
        post.location = location
        post.user = user
        try? mainRealm.write {
            self.mainRealm.add(post)
        }
    }
    
    func allpost() -> Results<Post> {
        return mainRealm.objects(Post.self)
    }
    
}
