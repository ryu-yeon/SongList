//
//  MapViewController.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/10.
//

import UIKit
import CoreLocation
import NMapsMap

class MapViewController: BaseViewController {
    
    private let mainView = MapView()
    
    var locationManager = CLLocationManager()
    
    var list: [Karaoke] = []
    
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        checkUserDeviceLocationServiceAuthorization()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func configure() {
        
        mainView.mapView.positionMode = .direction
        
    }
    
    func checkUserDeviceLocationServiceAuthorization() {
        
        let authorizationStatus: CLAuthorizationStatus
        
        authorizationStatus = locationManager.authorizationStatus
        
        if CLLocationManager.locationServicesEnabled() {
            checkUserCurrentLocationAuthorization(authorizationStatus)
        } else {
            print("위치 서비스가 꺼져 있어서 위치 권한 요청을 못합니다.")
        }
    }
    
    func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            print("NOTDETERMINED")
            
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()

        case .restricted, .denied:
            print("DENIED") // 아이폰 설정으로 유도
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            
        default: print("DEFAULT")
        }
        
    }
    
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let coordinate = locations.last?.coordinate {
            let x = String(coordinate.longitude)
            let y = String(coordinate.latitude)
    
            
            KakaoAPIManager.shared.requestKaraoke(text: "노래방", x: x, y: y, radius: 500) { list in
                self.list = list
                dump(list)
            }
            
            
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
    
}
