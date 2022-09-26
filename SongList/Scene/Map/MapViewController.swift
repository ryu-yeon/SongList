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
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        
        
        if CLLocationManager.locationServicesEnabled() {
            print("위치 서비스 On 상태")
            locationManager.startUpdatingLocation()
            print(locationManager.location?.coordinate)
        } else {
            print("위치 서비스 Off 상태")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func configure() {
        mainView.mapView.positionMode = .direction
        
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
}
