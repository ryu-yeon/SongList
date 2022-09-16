//
//  ChartAPIManager.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/14.
//

import Foundation

import Alamofire
import SwiftyJSON

class ChartAPIManager {
    
    static let shared = ChartAPIManager()
    
    func requestChart(limit: Int, range: String, compleitionHandler: @escaping ([Song])-> Void) {
        let url = EndPoint.chartURL + "tj/\(range).json"
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
                    let release = song["release"].stringValue
                    
                    let data = Song(number: number, title: title, artist: artist, composer: composer, lyricist: lyricist, release: release)
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
}
