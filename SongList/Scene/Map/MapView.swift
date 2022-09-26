//
//  MapView.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/10.
//

import UIKit

import SnapKit
import NMapsMap

class MapView: BaseView {
    
    let segmentControl: UISegmentedControl = {
        let view = UISegmentedControl(items: ["노래방", "코인노래방"])
        return view
    }()
    
    let mapView: NMFMapView = {
        let view = NMFMapView()
        return view
    }()
    
    let mapUIView: NMFNaverMapView = {
        let view = NMFNaverMapView()
        view.showLocationButton = true
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .systemBackground
        [segmentControl, mapView, mapUIView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setContraints() {
        segmentControl.snp.makeConstraints { make in
            make.top.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(40)
        }
        
        mapView.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        mapUIView.snp.makeConstraints { make in
            make.top.trailing.leading.bottom.equalTo(mapView).inset(0)
        }
    }
}
