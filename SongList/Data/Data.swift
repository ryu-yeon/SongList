//
//  Data.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/22.
//

import Foundation

struct Data {
    let data: [DataList] = [DataList(title: "캐롤", image:  "https://cdn.pixabay.com/photo/2019/11/06/20/33/santa-4607097_1280.png", songs: [Song(brand: "12", albumImage: "12", number: "12", title: "12", artist: "12", composer: "12", lyricist: "12", release: "12")])]
}

struct DataList {
    let title: String
    let image: String
    let songs: [Song]
}
