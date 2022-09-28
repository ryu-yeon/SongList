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
    
    let infoWindow = NMFInfoWindow()
    
    var url = ""

    
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

        mainView.urlButton.addTarget(self, action: #selector(urlButtonClicked), for: .touchUpInside)
    }

    
    func makeMaker(lat: Double, lng: Double) {
        let marker = NMFMarker()
        marker.position = NMGLatLng(lat: lat, lng: lng)
        marker.mapView = mainView.mapView
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
    
    @objc func urlButtonClicked() {
        let vc = WebViewController()
        vc.url = url
        present(vc, animated: true)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let coordinate = locations.last?.coordinate {
            let x = String(coordinate.longitude)
            let y = String(coordinate.latitude)
            
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: coordinate.latitude, lng: coordinate.longitude))
                        cameraUpdate.animation = .easeIn
            mainView.mapView.moveCamera(cameraUpdate)
            mainView.mapView.positionMode = .direction

            KakaoAPIManager.shared.requestKaraoke(text: "노래방", x: x, y: y, radius: 500) { list in
                self.list = list
                dump(list)
                for karaoke in list {
                    let lat = Double(karaoke.y) ?? 0
                    let lng = Double(karaoke.x) ?? 0
                    let marker = NMFMarker(position: NMGLatLng(lat: lat, lng: lng))
                    if karaoke.name.contains("코인") {
                        marker.iconTintColor = UIColor.red
                    }
                    marker.mapView = self.mainView.mapView
                    let handler = { [weak self] (overlay: NMFOverlay) -> Bool in
                        self?.mainView.nameLabel.text = karaoke.name
                        self?.mainView.distanceLabel.text = karaoke.distance + "m"
                        self?.mainView.addressLabel.text = karaoke.address
                        self?.mainView.urlButton.isHidden = false
                        self?.url = karaoke.url
                        return true
                    }
                    marker.touchHandler = handler
                }
            }
        }
        
        locationManager.stopUpdatingLocation()
    }
    

    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
    
}
