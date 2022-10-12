//
//  ListRepository.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/20.
//

import Foundation

import RealmSwift

protocol ListRepositoryType {
    func fetch() -> Results<ListRealm>
    func saveList(title: String, color: String, image: String)
    func removeList(task: ListRealm)
    func updateList(task: ListRealm, title: String, color: String, image: String)
}

class ListRepository: ListRepositoryType {
    
    let localRealm = try! Realm()
    
    func fetch() -> Results<ListRealm> {
        return localRealm.objects(ListRealm.self)
    }
    
    func saveList(title: String, color: String, image: String) {
        do {
            try localRealm.write {
                let task = ListRealm(title: title, color: color, image: image, songs: List<SongRealm>())
                localRealm.add(task)
            }
        } catch {
            print("실패", #function)
        }
    }
    
    func removeList(task: ListRealm) {
        do {
            try localRealm.write {
                localRealm.delete(task)
            }
        } catch {
            print("실패", #function)
        }
    }
    
    func removeSong(task: ListRealm, index: Int) {
        do {
            try localRealm.write {
                localRealm.delete(task.songs[index])
            }
        } catch {
            print("실패", #function)
        }
    }
    
    func updateList(task: ListRealm, title: String, color: String, image: String) {
        do {
            try localRealm.write {
                task.title = title
                task.color = color
                task.image = image
            }
        } catch {
            print("실패", #function)
        }
    }
    
    func addSong(task: ListRealm, song: Song) {
        do {
            try localRealm.write {
                task.songs.append(SongRealm(brand: song.brand, number: song.number, title: song.title, artist: song.artist, composer: song.composer, lyricist: song.lyricist, release: song.release, albumImage: song.albumImage))
            }
        } catch {
            print("실패", #function)
        }
    }
}
