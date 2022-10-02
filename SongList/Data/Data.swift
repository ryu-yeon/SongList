//
//  Data.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/22.
//

import Foundation

struct Data {
    let data: [DataList] = [DataList(title: "커플 듀엣", image: "https://cdn-icons-png.flaticon.com/512/4533/4533829.png", songs:
                                        [Song(brand: "tj", albumImage: "", number: "45917", title: "Dream", artist: "수지(미스에이),백현(EXO)", composer: "박근태,최진석", lyricist: "김이나", release: "2016-01-01"),
                                         Song(brand: "tj", albumImage: "https://i.scdn.co/image/ab67616d0000b27390eca65ed86cc92fd599a81e", number: "32663", title: "잔소리", artist: "IU(With 임슬옹(2AM))", composer: "이민수", lyricist: "김이나", release: "2010-06-01"),
                                        Song(brand: "tj", albumImage: "https://i.scdn.co/image/ab67616d0000b273f31c5b39f111bd99784f5513", number: "35774", title: "All For You(응답하라1997 OST)", artist: "서인국,정은지", composer: "김한범", lyricist: "정진환", release: "2012-09-01"),
                                        Song(brand: "tj", albumImage: "", number: "76509", title: "LOVE DAY(바른연애길잡이X양요섭,정은지)", artist: "양요섭,정은지", composer: "김건우", lyricist: "김이나", release: "2021-03-10"),
                                         Song(brand: "tj", albumImage: "https://i.scdn.co/image/ab67616d0000b2738a8800559351735cfa923ab8", number: "29110", title: "우연히봄(냄새를보는소녀OST)", artist: "로꼬,유주(여자친구", composer: "피터팬,똘아이박,미친기집애", lyricist: "LOCO,최재우", release: "2015-04-01"),
                                        Song(brand: "tj", albumImage: "", number: "35743", title: "I Need You", artist: "허각,지아", composer: "이단옆차기1,이단옆차기3", lyricist: "이단옆차기1,이단옆차기2", release: "2012-08-01"),
                                        Song(brand: "tj", albumImage: "https://i.scdn.co/image/ab67616d0000b27361166666e32b86c3e9a7b78b", number: "38010", title: "썸", artist: "소유,정기고(Feat.릴보이(긱스))", composer: "김도훈,XEPY,ESNA", lyricist: "오승택,ESNA,JUNGGIGO,민연재,XEPY", release: "2014-02-01"),
                                        Song(brand: "tj", albumImage: "https://i.scdn.co/image/ab67616d0000b273aedf2fa2159302cdd748f02a", number: "38569", title: "한여름밤의꿀", artist: "San E,레이나", composer: "코스믹사운드,정산", lyricist: "정산", release: "2014-06-01"),
                                         Song(brand: "tj", albumImage: "https://i.scdn.co/image/ab67616d0000b273dae35513871556fbe9f530a8", number: "34593", title: "그남자그여자", artist: "4MEN,미(MIIII)", composer: "E-TRIBE", lyricist: "E-TRIBE,민연재", release: "2011-11-01"),
                                        Song(brand: "tj", albumImage: "https://i.scdn.co/image/ab67616d0000b273d22351424b334dd54c1c39cf", number: "766851", title: "다정히내이름을부르면", artist: "경서예지,전건호", composer: "", lyricist: "", release: ""),
                                         Song(brand: "tj", albumImage: "https://i.scdn.co/image/ab67616d0000b273201eb0a8f7bf25947f08ae74", number: "45367", title: "보통연애", artist: "박경(블락비)(Feat.박보람)", composer: "박경,KERO ONE", lyricist: "박경", release: "2015-09-01"),
                                        Song(brand: "tj", albumImage: "https://i.scdn.co/image/ab67616d0000b273900027469740772e3009f9da", number: "36928", title: "짧은머리", artist: "허각,정은지", composer: "박치기,이단옆차기1,이단옆차기2", lyricist: "이단옆차기1,이단옆차기2", release: "2013-06-01"),
                                        Song(brand: "tj", albumImage: "https://i.scdn.co/image/ab67616d0000b273470896bb09bb41c3d974f2ff", number: "35805", title: "우리사랑이대로(응답하라1997 OST)", artist: "서인국,정은지", composer: "주영훈", lyricist: "주영훈", release: "2012-09-01"),
                                        Song(brand: "tj", albumImage: "https://i.scdn.co/image/ab67616d0000b27324e3a833a37b6904e5e26e8a", number: "46467", title: "자격지심", artist: "박경(블락비)(Feat.은하(여자친구))", composer: "박경,SCORE<MEGATONE", lyricist: "박경", release: "2016-05-01"),
                                        Song(brand: "tj", albumImage: "", number: "46876", title: "Say Yes(달의연인-보보경심려OST)", artist: "로꼬,펀치", composer: "로코베리(ROCOBERRY)", lyricist: "지훈,LOCO", release: "2016-09-01"),
                                        Song(brand: "tj", albumImage: "", number: "46847", title: "잠은다잤나봐요(구르미그린달빛OST)", artist: "소유,유승우", composer: "개미,김세진", lyricist: "개미,요다", release: "2016-08-01"),
                                        Song(brand: "tj", albumImage: "https://i.scdn.co/image/ab67616d0000b273dee939766dfa630f32b85756", number: "32106", title: "첫사랑이죠", artist: "IU,나윤권", composer: "심현보", lyricist: "김윤희,심현보", release: "2010-01-01"),
                                        Song(brand: "tj", albumImage: "https://i.scdn.co/image/ab67616d0000b27339502ffb74ba9a447f392ccb", number: "33116", title: "그대네요", artist: "성시경,IU", composer: "김형석", lyricist: "이미나", release: "2010-10-01")]),
                            DataList(title: "남자 발라드", image: "https://cdn-icons-png.flaticon.com/512/3948/3948252.png", songs: [Song(brand: "tj", albumImage: "", number: "14515", title: "응급실(쾌걸춘향OST)", artist: "izi", composer: "신동우", lyricist: "신동우", release: ""),                                                                                                                                                                                                                                Song(brand: "tj", albumImage: "https://i.scdn.co/image/ab67616d0000b273a7c13924d0869668ddb0f22e", number: "11491", title: "소주한잔", artist: "임창정", composer: "이동원", lyricist: "임창정", release: ""),
                                                                     Song(brand: "tj", albumImage: "https://i.scdn.co/image/ab67616d0000b27330623d491400e1516d3fca59", number: "49818", title: "좋니", artist: "윤종신", composer: "POSTINO", lyricist: "윤종신", release: "2017-06-30"),
                                                                     Song(brand: "tj", albumImage: "https://i.scdn.co/image/ab67616d0000b273b1e699e6e60ec54bbf0b7e8f", number: "14684", title: "가시", artist: "버즈", composer: "윤우현", lyricist: "임선아", release: ""),
                                                                     Song(brand: "tj", albumImage: "https://i.scdn.co/image/ab67616d0000b273d04eaf92f704aaf61c686b48", number: "9551", title: "벌써일년", artist: "브라운아이즈", composer: "윤건", lyricist: "한경혜", release: ""),
                                                                     Song(brand: "tj", albumImage: "https://i.scdn.co/image/ab67616d0000b273a96f6560c7e9f8ff05dbf284", number: "14238", title: "눈의꽃(미안하다사랑한다OST)", artist: "박효신", composer: "MATSUMOTO,RYOKI", lyricist: "SATOMI", release: ""),
                                                                        Song(brand: "tj", albumImage: "", number: "17468", title: "감사", artist: "김동률", composer: "김동률", lyricist: "김동률", release: "2007-03-01"),
                                                                        Song(brand: "tj", albumImage: "", number: "15978", title: "남자를몰라", artist: "버즈", composer: "이상준", lyricist: "김진아", release: ""),
                                                                        Song(brand: "tj", albumImage: "https://i.scdn.co/image/ab67616d0000b2731464705f34b863c0391c78c6", number: "13588", title: "삭제", artist: "이승기", composer: "싸이", lyricist: "싸이", release: ""),
                                                                        Song(brand: "tj", albumImage: "", number: "15865", title: "고백", artist: "4MEN", composer: "윤민수", lyricist: "유성규", release: ""),
                                                                        Song(brand: "tj", albumImage: "https://i.scdn.co/image/ab67616d0000b273630100e7646e4939206310d5", number: "34687", title: "안아줘", artist: "정준일", composer: "정준일", lyricist: "정준일", release: "2011-12-01"),
                                                                        Song(brand: "tj", albumImage: "https://i.scdn.co/image/ab67616d0000b273d302508be9a23d452069eaa2", number: "62351", title: "너였다면(또오해영OST)", artist: "정승환", composer: "1601,1601A", lyricist: "김미진", release: "2016-06-01"),
                                                                         Song(brand: "tj", albumImage: "https://i.scdn.co/image/ab67616d0000b273262a53a728d8cce57f504626", number: "96636", title: "가을안부", artist: "먼데이키즈", composer: "LOHI 2,한상원,이진성", lyricist: "강은경", release: ""),
                                                                         Song(brand: "tj", albumImage: "", number: "97511", title: "모든날, 모든순간(Every Day, Every Moment)(키스먼저할까요? OST)", artist: "폴킴", composer: "어깨깡패1,어깨깡패2", lyricist: "어깨깡패1,어깨깡패2", release: "2018-03-28"),
                                                                        Song(brand: "tj", albumImage: "https://i.scdn.co/image/ab67616d0000b2733fdb4250dac291b4c53879cd", number: "38028", title: "너의모든순간(별에서온그대OST)", artist: "성시경", composer: "성시경", lyricist: "심현보", release: "2014-02-01"),
                                                                        Song(brand: "tj", albumImage: "", number: "2730", title: "가질수없는너", artist: "뱅크", composer: "정시로", lyricist: "강은경", release: "")]),
    DataList(title: "여자 발라드", image: "https://cdn-icons-png.flaticon.com/512/522/522349.png", songs: [Song(brand: "tj", albumImage: "https://i.scdn.co/image/ab67616d0000b273462fe3cc2bb66d480dee263a", number: "48470", title: "첫눈처럼너에게가겠다(도깨비OST)", artist: "에일리", composer: "로코,코난", lyricist: "이미나", release: "2017-01-01"),
                                                Song(brand: "tj", albumImage: "", number: "11019", title: "체념", artist: "빅마마", composer: "이영현", lyricist: "이영현", release: ""),
                                                Song(brand: "tj", albumImage: "https://i.scdn.co/image/ab67616d0000b2739017c822675d2c5a8ff2437c", number: "11238", title: "친구라도될걸그랬어", artist: "거미", composer: "김도훈", lyricist: "황성진,박경진", release: ""),
                                                Song(brand: "tj", albumImage: "https://i.scdn.co/image/ab67616d0000b273a1c7e8be65c82b60f0be1e68", number: "62627", title: "180도", artist: "벤(Ben)", composer: "류재현,최성일", lyricist: "류재현,최성일", release: "2018-12-08"),
                                                 Song(brand: "tj", albumImage: "https://i.scdn.co/image/ab67616d0000b273fc1979594927084b7cf42b86", number: "97814", title: "열애중", artist: "벤(Ben)", composer: "류재현,최성일", lyricist: "류재현,최성일,민연재", release: "2018-05-28"),
                                                Song(brand: "tj", albumImage: "https://i.scdn.co/image/ab67616d0000b27306f56375a6f108349ebafe45", number: "35138", title: "곰인형", artist: "린(Feat.해금)", composer: "윤민수", lyricist: "윤민수,민연재", release: "2012-03-01"),
                                                Song(brand: "tj", albumImage: "", number: "19187", title: "만약에(쾌도홍길동OST)", artist: "태연(소녀시대)", composer: "김준범,이창희", lyricist: "송재원", release: "2008-01-01"),
                                                Song(brand: "tj", albumImage: "https://i.scdn.co/image/ab67616d0000b2731e3a9bcd61275e8eb340035e", number: "9732", title: "늦은후회", artist: "보보", composer: "김형석", lyricist: "양재선", release: ""),
                                                 Song(brand: "tj", albumImage: "https://i.scdn.co/image/ab67616d0000b273b4a1e79ddba80b26c85c64df", number: "15871", title: "사랑안해", artist: "백지영", composer: "박근태", lyricist: "차은택", release: ""),
                                                Song(brand: "tj", albumImage: "https://i.scdn.co/image/ab67616d0000b273584dc7d6042f1c76f58d75bb", number: "16677", title: "기다리다", artist: "윤하", composer: "윤하", lyricist: "심재희", release: ""),
                                                Song(brand: "tj", albumImage: "https://i.scdn.co/image/ab67616d0000b273d36b48557efcdda8a3a469b1", number: "9610", title: "화장을고치고", artist: "WAX", composer: "", lyricist: "", release: "")])]
}

struct DataList {
    let title: String
    let image: String
    let songs: [Song]
}
