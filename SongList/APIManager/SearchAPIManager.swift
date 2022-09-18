//
//  SearchAPIManager.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/14.
//

import Foundation

import Alamofire
import SwiftyJSON

class SearchAPIManager {
    
    static let shared = SearchAPIManager()
    
    func requestSong(text: String, type: String, brand: String, completionHandler: @escaping ([Song])-> Void) {
        
        let title = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        let url = EndPoint.searchURL + "/\(type)/\(title)/\(brand)" + ".json"
        
        print(url)
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                var list: [Song] = []
                
                for song in json.arrayValue {
                    let number = song["no"].stringValue
                    let title = song["title"].stringValue
                    let artist = song["singer"].stringValue
                    let composer = song["composer"].stringValue
                    let lyricist = song["lyricist"].stringValue
                    let release = song["release"].stringValue
                    
                    let data = Song(number: number, title: title, artist: artist, composer: composer, lyricist: lyricist, release: release)
                    list.append(data)
                }
                completionHandler(list)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
