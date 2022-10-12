//
//  SearchTextRealm.swift
//  SongList
//
//  Created by 유연탁 on 2022/10/12.
//

import Foundation

import RealmSwift

class SearchTextRealm: Object {
    @Persisted var text: String
    @Persisted var date: Date
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(text: String, date: Date) {
        self.init()
        self.text = text
        self.date = Date()
    }
}
