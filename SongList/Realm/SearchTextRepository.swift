//
//  SearchTextRepository.swift
//  SongList
//
//  Created by 유연탁 on 2022/10/12.
//

import Foundation

import RealmSwift

protocol SearchTextRepositoryType {
    func fetchSort() -> Results<SearchTextRealm>
    func saveText(text: String)
    func removeText(task: SearchTextRealm)
}

class SearchTextRepository: SearchTextRepositoryType {
    
    let localRealm = try! Realm()
    
    func fetchSort() -> Results<SearchTextRealm> {
        return localRealm.objects(SearchTextRealm.self).sorted(byKeyPath: "date", ascending: false)
    }
    
    func saveText(text: String) {
        do {
            try localRealm.write {
                let task = SearchTextRealm(text: text, date: Date())
                localRealm.add(task)
            }
        } catch {
            print("실패", #function)
        }
    }
    
    func removeText(task: SearchTextRealm) {
        do {
            try localRealm.write {
                localRealm.delete(task)
            }
        } catch {
            print("실패", #function)
        }
    }
}
