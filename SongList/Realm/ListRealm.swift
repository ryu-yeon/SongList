//
//  ListRealm.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/20.
//

import Foundation

import RealmSwift

class ListRealm: Object {
    @Persisted var title: String
    @Persisted var color: String
    @Persisted var songs: List<SongRealm>
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(title: String, color: String, songs: List<SongRealm>) {
        self.init()
        self.title = title
        self.color = color
        self.songs = songs
    }
}
