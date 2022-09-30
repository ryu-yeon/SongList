//
//  MapViewController.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/10.
//

import UIKit
import CoreLocation

import NMapsMap
import Hero

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
        self.isHeroEnabled = true
        mainView.mapLabel.heroID = "mapLabel"
    }
    
    override func configure() {

        mainView.urlButton.addTarget(self, action: #selector(urlButtonClicked), for: .touchUpInside)
        mainView.currentButton.addTarget(self, action: #selector(currentButtonClicked), for: .touchUpInside)
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
            print("DENIED")
            let alert = UIAlertController(title: "위치 권한이 필요합니다.", message: "개인정보 보호 및 보안-위치 서비스-뭐부르지 에서 위치 권한을 허용해주세요. ", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .destructive) { _ in
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }
            let cancel = UIAlertAction(title: "아니오", style: .cancel)
            alert.addAction(ok)
            alert.addAction(cancel)
            present(alert, animated: true)
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            
        default: print("DEFAULT")
        }
    }
    
    @objc func currentButtonClicked() {
        mainView.mapView.positionMode = .compass
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
            
            KakaoAPIManager.shared.requestKaraoke(text: "노래방", x: x, y: y, radius: 1000, page: 1) { list, isEnd  in
                self.list.append(contentsOf: list)
                if isEnd == false {
                    KakaoAPIManager.shared.requestKaraoke(text: "노래방", x: x, y: y, radius: 1000, page: 2) { list, isEnd  in
                        self.list.append(contentsOf: list)
                        for karaoke in self.list {
                            let lat = Double(karaoke.y) ?? 0
                            let lng = Double(karaoke.x) ?? 0
                            let marker = NMFMarker(position: NMGLatLng(lat: lat, lng: lng))
                            if karaoke.name.contains("코인") {
                                marker.iconTintColor = UIColor.red
                            }
                            marker.mapView = self.mainView.mapView
                            let handler = { [weak self] (overlay: NMFOverlay) -> Bool in
                                let dataSource = NMFInfoWindowDefaultTextSource.data()
                                if let marker = overlay as? NMFMarker {
                                    if marker.infoWindow == nil {
                                        dataSource.title = "선택"
                                        self?.infoWindow.dataSource = dataSource
                                        self?.infoWindow.open(with: marker)
                                    } else {
                                        self?.infoWindow.close()
                                    }
                                }
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
            }
        }
        locationManager.stopUpdatingLocation()
    }
    

    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
    
}
