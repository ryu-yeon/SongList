# **뭐 부르지? - 내 맘대로 만드는 노래방 곡 리스트**

<img src="https://velog.velcdn.com/images/rytak108/post/b91aaee0-fe95-4167-af04-7d46654db7ea/image.png">

## **📲 앱 소개**
### 검색, 인기차트를 통해 부르고 싶은 노래방 곡을 찾고 리스트에 저장하는 앱
- 노래방 곡 제목, 가수 검색
- 노래 리스트 제목, 아이콘, 색상 꾸미기
- 일간, 주간, 월간 노래방 인기차트 제공
- 현재 위치 주변 노래방 찾기


<a href="https://apps.apple.com/kr/app/%EB%AD%90-%EB%B6%80%EB%A5%B4%EC%A7%80-%EB%82%B4-%EB%A7%98%EB%8C%80%EB%A1%9C-%EB%A7%8C%EB%93%9C%EB%8A%94-%EB%85%B8%EB%9E%98-%EB%A6%AC%EC%8A%A4%ED%8A%B8/id6443573821" target="_blank"><img src="https://developer.apple.com/news/images/download-on-the-app-store-badge.png" width="150px" /></a>  

## **🗓️ 개발기간**
### 2022.09.12 ~ 2022.10.09 (4주)  

---
## **🛠️ Framwork & Tech Stack**
- ### ```MVC```
- ### ```UIKit```, ```CoreLocation```, ```Push Notification```, ```WebKit```
- ### ```SnapKit```, ```Alamofire```, ```SwiftyJSON```, ```Realm```, ```NaverMap```, ```Kingfisher```, ```Firebase Cloud Messaging```, ```Firebase Analytics```, ```Toast```, ```Hero```, ```PanModal```

---
## **🔴 Trouble Shooting**

### 1. TableViewCell 안의 ColletionView의 버튼 이벤트 작동 ❌

- Cell에서 ```self```가 아닌 ```contentView```에 ```addSubView```로 해결.
```swift
[chartLabel, chartImageView, chartButton, tjButton, kyButton, chartCollectionView].forEach {
    contentView.addSubview($0)
}
```
### 2. Realm DB에 컬러값 저장
- 컬러값을 Hex 문자열 값으로 저장

```swift
extension UIColor {
    convenience init(hexFromString: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexFromString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}
```

### 3. Cell안의 값 ViewController로 전달
- TableView안의 클릭된 ColletionView Cell ```indexPath```값을 Delegate를 통해 전달

1. ColletionView Cell에서 Protocol을 선언해주고 delegate 프로퍼티를 선언한다.
2. 보내줄 데이터를 파라미터로 넣어서 호출한다.
3. 값을 받는 ViewController에서 Protocol을 채택하고, 메소드를 구현해준다.
4. delegate 대리자를 위임해준다.

### 4. ColletionView 스크롤 페이징
- 이동한 x좌표 값과 item의 크기를 비교 후 페이징 값 설정
- item 절반 사이즈 만큼 스크롤로 판단하여 올림, 내림 처리후 페이징 될 좌표 값을 targetContentOffset에 대입하여 해결

```swift
extension ChartTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let layout = self.chartCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
                
                let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
                
                let estimatedIndex = scrollView.contentOffset.x / cellWidthIncludingSpacing
                let index: Int
                if velocity.x > 0 {
                    index = Int(ceil(estimatedIndex))
                } else if velocity.x < 0 {
                    index = Int(floor(estimatedIndex))
                } else {
                    index = Int(round(estimatedIndex))
                }
                
                targetContentOffset.pointee = CGPoint(x: CGFloat(index) * cellWidthIncludingSpacing, y: 0)
    }
}
```

### 5. 노래 리스트 DB 구성
- 리스트(제목, 컬러, 아이콘, 수록곡) -> 수록곡(브랜드, 번호, 제목, 가수, 작곡가, 작사가, 출시일, 앨범 이미지 url)을 Realm List를 활용하여 2개의 테이블로 구성

```swift
class ListRealm: Object {
    @Persisted var title: String
    @Persisted var color: String
    @Persisted var image: String
    @Persisted var songs: List<SongRealm>
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(title: String, color: String, image: String,songs: List<SongRealm>) {
        self.init()
        self.title = title
        self.image = image
        self.color = color
        self.songs = songs
    }
}

class SongRealm: Object {
    @Persisted var brand: String
    @Persisted var number: String
    @Persisted var title: String
    @Persisted var artist: String
    @Persisted var composer: String
    @Persisted var lyricist: String
    @Persisted var release: String
    @Persisted var albumImage: String
    
    convenience init(brand: String, number: String, title: String, artist: String, composer: String, lyricist: String, release: String, albumImage: String) {
        self.init()
        self.brand = brand
        self.number = number
        self.title = title
        self.artist = artist
        self.composer = composer
        self.lyricist = lyricist
        self.release = release
        self.albumImage = albumImage
    }
}
```
---

## **🤔 회고**
- 한 화면에 여러 구성들을 깔끔하게 정리해 보여주기위해 여러 단계의 ```TableView```와 ```CollectionView```를 혼합하여 구성하였는데 ```CompositionalLayout```을 이용하여 하나의 ```CollectionView```를 이용하여 리펙토링한다면 좀 간결한 코드 구성이 되지않을까 생각된다.
- 최초 기획 당시 앨범커버 이미지를 Spotify API를 통하여 받아와 앱에서 보여주려고 했는데 앱스토어 심사과정에서 저작권 관련 규정과 노래 검색에서 연령제한이 있는 곡도 검색할수 있어 연령제한 규정으로 2번의 리젝을 경험했다. 이 경험을 통해 앱스토어 심사규정을 다시 한번 꼼꼼하게 읽어보는 계기가 되었다.
- 네트워크가 연결되지 않았을때는 홈화면에서 인기차트가 보이지않는다. 다은 업데이트에서 최근 실행시 인기차트를 저장해 두었다가 네트워크가 연결되지 않았을때 보여는 방식으로 개선해보면 좋을것같다.
- ```@escaping``` 클로저를 사용하거나 delegate 사용시에 순환참조가 발생하는 경우에 어떻게 대응할지에 대해 생각해보게되었다.
- 이미지나 폰트의 소스값들을 리터럴보다는 ```enum```을 통하여 추상화시켜 소스관리를 용이하게하지 못한것이 아쉬움으로 남는다. 다음 업데이트에서 추상화시켜보도록 하겠다.