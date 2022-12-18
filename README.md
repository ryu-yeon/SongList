# **뭐 부르지? - 내 맘대로 만드는 노래방 곡 리스트?**

<img src="https://velog.velcdn.com/images/rytak108/post/b91aaee0-fe95-4167-af04-7d46654db7ea/image.png">

<br> 

## **앱스토어 바로가기 Version 1.1.3**

<a href="https://apps.apple.com/kr/app/%EB%AD%90-%EB%B6%80%EB%A5%B4%EC%A7%80-%EB%82%B4-%EB%A7%98%EB%8C%80%EB%A1%9C-%EB%A7%8C%EB%93%9C%EB%8A%94-%EB%85%B8%EB%9E%98-%EB%A6%AC%EC%8A%A4%ED%8A%B8/id6443573821" target="_blank"><img src="https://developer.apple.com/news/images/download-on-the-app-store-badge.png" width="200px" /></a>  

## **개발기간**
### 2022.09.12 ~ 2022.10.09 (4주)  


<br>

---
## **🛠️ Framwork & Tech Stack**
- ### MVC
- ### UIKit
- ### SnapKit
    - CodeBase UI, AutoLayout 구성
- ### Alamofire, SwiftyJSON
    - 네트워크 통신에서 Alamofire를 이용
    - 통신으로 받은 JSON 데이터를 SwiftyJSON으로 파싱
- ### Realm
    - 유저가 저장한 노래 리스트 DB
- ### Core Location, NaverMap
    - Core Location으로 현재위치정보 얻기
    - NaverMap으로 지도 표시, 마커 표시, 나침반 기능
- ### Firebase Analytics
    - 유저 이벤트, 사용유형 정보 수집
- ### FCM, Push Notification
    - 유저 이벤트 푸시메세지 알림
- ### WebKit
    - 웹페이지 실행
- ### Kingfisher
    - 이미지 처리
- ### Toast
    - 간단한 팝업 메세지 UI 구성
- ### Hero
    - View의 다이나믹한 화면전환 애니매션 구성
- ### PanModal

<br>

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

<br>

---

## **✍🏻 Learnd**

- ### TableView, ColletionView
    - 한 화면에 여러 구성들을 깔끔하게 정리해 보여주기위해 여러 단계의 TableView와 CollectionView를 이용하여 화면을 구성한것이 delegate를 이용한 값전달이나 layout을 능숙하게 활용하는데 도움이 되었다.

- ### API 통신
    - API 통신을 할때 데이터를 처리하는 시점이 중요한것같다. API의 정보를 어떻게 보여줄지, Indicator도 알맞게 설정해야 하는지도 생각해보게 되었다. 

- ### Realm DB 구성
    - DB를 어떠한 구조로 구성해야 데이터를 편하게 관리할 수 있을지 알게되었다.

- ### 1인 출시 앱
    - 기획부터 디자인, 개발까지 앱의 모든 점을 혼자 구상하고 만드는데 어려움이 많았다. 앱을 기획하고 화면을 만들때 사용자 경험을 생각하며 구성해야한다고 느꼈다. 

- ### 앱스토어 출시
    - 앨범아트의 저작권 관련, 연령제한 2번의 리젝 경험으로 앱스토어의 심사기준에 대해 좀 더 세심하게 다루어야 한다.
    - TestFlight 테스트를 통해 실기기로 다양한 테스트를 하고 에러를 잡는 과정이 많은 도움이 되었다.

