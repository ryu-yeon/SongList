//
//  SongRealm.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/21.
//

import Foundation

import RealmSwift

class SongRealm: Object {
    @Persisted var brand: String
    @Persisted var number: String
    @Persisted var title: String
    @Persisted var artist: String
    @Persisted var composer: String
    @Persisted var lyricist: String
    @Persisted var release: String
    @Persisted var albumImage: String
    
    convenience init(brand: String, number: String, title: String, artist: String, composer: String, lyricist: String, release: String, albumImage: String) {
        self.init()
        self.brand = brand
        self.number = number
        self.title = title
        self.artist = artist
        self.composer = composer
        self.lyricist = lyricist
        self.release = release
        self.albumImage = albumImage
    }
}
