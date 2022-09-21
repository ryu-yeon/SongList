//
//  SpotifyAPIManager.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/14.
//

import Foundation

import Alamofire
import SwiftyJSON

class SpotifyAPIManager {
    
    static let shared = SpotifyAPIManager()
    
    func callToken(complietionHandler: @escaping (String) -> Void) {
        
        var token = ""
        let parameters = ["client_id" : APIKey.spotifyID,
                          "client_secret" : APIKey.spotifySecret,
                          "grant_type" : "client_credentials"]
        AF.request("https://accounts.spotify.com/api/token", method: .post, parameters: parameters).responseJSON(completionHandler: {
            response in
            
            switch response.result {
            case .success(let value):
                
                let jsonData = value as! NSDictionary
                token = jsonData.value(forKey: "access_token") as? String ?? ""
                
                complietionHandler(token)
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func requestSong(token: String, song: String, singer: String, completionHandler: @escaping (String) -> Void) {
        let title = song.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = "https://api.spotify.com/v1/search?access_token=\(token)&q=\(title)&type=track"
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                var albumCover = "https://cdn-icons-png.flaticon.com/512/4505/4505303.png"
                for song in json["tracks"]["items"].arrayValue {
                    let artist = song["artists"][0]["name"].stringValue
                    //                            print(artist)
                    if artist == singer {
                        let albumImage = song["album"]["images"][0]["url"].stringValue
                        albumCover = albumImage
                        break
                    }
                }
                
                completionHandler(albumCover)
            case .failure(let error):
                print(error)
            }
        }
    }
}
