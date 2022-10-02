//
//  FlatIconAPIManager.swift
//  SongList
//
//  Created by 유연탁 on 2022/10/03.
//

import Foundation

import Alamofire
import SwiftyJSON

class FlatIconAPIManager {
    static let shared = FlatIconAPIManager()
    
    func requestToken(complietionHandler: @escaping (String) -> Void) {
        let url = "https://api.flaticon.com/v3/app/authentication?apikey=\(APIKey.flatIconApi)"
        let header: HTTPHeaders = ["Content-Type": "multipart/form-data", "Accept": "application/json"]
        AF.request(url, method: .post, headers: header).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
                let token = json["data"]["token"].stringValue
                
                complietionHandler(token)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestIcon(text: String, token: String, complietionHandler: @escaping ([String]) -> Void) {
        let searchText = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = "https://api.flaticon.com/v3/search/icons" + "?q=\(searchText)"
        let header: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        AF.request(url, method: .get, headers: header).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
                var iconList: [String] = []
                for icon in json["data"].arrayValue {
                    iconList.append(icon["images"]["128"].stringValue)
                }
                complietionHandler(iconList)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
