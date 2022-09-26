//
//  KakaoAPIManager.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/26.
//

import Foundation

import Alamofire
import SwiftyJSON

class KakaoAPIManager {
    static let shared = KakaoAPIManager()
    
    func requestKaraoke(text: String, x: String, y: String, radius: Int,  compleitionHandler: @escaping ([Karaoke])-> Void) {
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = EndPoint.kakaoURL + "query=\(query)&x=\(x)&y=\(y)&radius=\(radius)"
        let header: HTTPHeaders = ["Authorization": APIKey.kakaoApi]
        AF.request(url, method: .get, headers: header).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
                
                var list: [Karaoke] = []
                
                for karaoke in json["documents"].arrayValue {
                    let name = karaoke["place_name"].stringValue
                    let distance = karaoke["distance"].stringValue
                    let address = karaoke["road_address_name"].stringValue
                    let x = karaoke["x"].stringValue
                    let y = karaoke["y"].stringValue
                    let url = karaoke["place_url"].stringValue
                    let phone = karaoke["phone"].stringValue
                    
                    let data = Karaoke(name: name, distance: distance, address: address, x: x, y: y, url: url, phone: phone)
                    list.append(data)
                }
                
                compleitionHandler(list)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
