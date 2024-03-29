//
//  KaraokeAPIManager.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/14.
//

import Foundation

import Alamofire
import SwiftyJSON

class KaraokeAPIManager {
    
    static let shared = KaraokeAPIManager()
    
    func requestChart(limit: Int, range: String, brand: String, compleitionHandler: @escaping ([Song])-> Void) { 
        let url = EndPoint.chartURL + "\(brand)/\(range).json"
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                var chart: [Song] = []
                var i = 0
                for song in json.arrayValue {
                    i += 1
                    
                    let number = song["no"].stringValue
                    let title = song["title"].stringValue
                    let artist = song["singer"].stringValue
                    let composer = song["composer"].stringValue
                    let lyricist = song["lyricist"].stringValue
                    var release = song["release"].stringValue
                    let brand = song["brand"].stringValue
                    
                    if release == "0000-00-00" {
                        release = ""
                    }
                    
                    let data = Song(brand: brand, albumImage: "", number: number, title: title, artist: artist, composer: composer, lyricist: lyricist, release: release)
                    chart.append(data)
                    if i == limit {
                        break
                    }
                }
                compleitionHandler(chart)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestSearch(text: String, type: String, brand: String, completionHandler: @escaping ([Song])-> Void) {
        
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
                    var release = song["release"].stringValue
                    if release == "0000-00-00" {
                        release = ""
                    }
                    let brand = song["brand"].stringValue
                    
                    let data = Song(brand: brand, albumImage: "", number: number, title: title, artist: artist, composer: composer, lyricist: lyricist, release: release)
                    list.append(data)
                }
                completionHandler(list)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestSearchSinger(text: String, brand: String, songTitle: String, completionHandler: @escaping ([Song])-> Void) {
        
        let title = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        let url = EndPoint.searchURL + "/singer/\(title)/\(brand)" + ".json"
        
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                var list: [Song] = []
                var i = 0
                for song in json.arrayValue {
                    if i > 10 {
                        break
                    }
                    let title = song["title"].stringValue
                    if title == songTitle {
                        continue
                    }
                    let artist = song["singer"].stringValue
                    if artist != text {
                        continue
                    }
                    i += 1
                    let number = song["no"].stringValue
                    let composer = song["composer"].stringValue
                    let lyricist = song["lyricist"].stringValue
                    var release = song["release"].stringValue
                    let brand = song["brand"].stringValue
                    if release == "0000-00-00" {
                        release = ""
                    }
                    
                    let data = Song(brand: brand, albumImage: "", number: number, title: title, artist: artist, composer: composer, lyricist: lyricist, release: release)
                    list.append(data)
                    
                }
                completionHandler(list)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
