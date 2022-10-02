//
//  Contents.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/14.
//

import Foundation

struct EndPoint {
    static let chartURL = "https://api.manana.kr/karaoke/popular/"
    static let searchURL = "https://api.manana.kr/karaoke"
    static let kakaoURL = "https://dapi.kakao.com/v2/local/search/keyword.json?"
    
    static let youtubeURL =  "https://m.youtube.com/results?sp=mAEA&search_query="
    static let lyricsNaverSearch = "https://m.search.naver.com/search.naver?sm=mtp_hty.top&where=m&query="
    static let infoURL = "https://interesting-cow-b5d.notion.site/5015ecd9c78b4467ae2a4f7873eace7e"
}

enum Menu: String {
    case first = "노래 리스트"
    case second = "인기차트"
    case thrid = "주변 노래방 찾기"
}

enum Brand: String {
    case tj
    case kumyoung
}

enum BrandText: String {
    case TJ
    case KY
}

enum ListType: String {
    case my = "마이"
    case recommand = "추천"
}

enum SearchType: String {
    case song
    case singer
}

enum Range: String {
    case daily
    case weekly
    case monthly
}

enum RangeText: String {
    case daily = "일간"
    case weekly = "주간"
    case monthly = "월간"
}
