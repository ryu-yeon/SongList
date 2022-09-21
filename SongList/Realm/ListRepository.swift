//
//  ListRepository.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/20.
//

import Foundation

import RealmSwift

protocol ListRepositoryType {
    func saveList(title: String, color: String)
}

class ListRepository: ListRepositoryType {
    
    let localRealm = try! Realm()
    
    func saveList(title: String, color: String) {
        do {
            try localRealm.write {
                let task = ListRealm(title: title, color: color, songs: List<SongRealm>())
                localRealm.add(task)
            }
        } catch {
            print("실패", #function)
        }
    }
}
