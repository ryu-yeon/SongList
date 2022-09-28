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
    
    let mapView: NMFMapView = {
        let view = NMFMapView()
        return view
    }()
    
    let infoContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .white
        return view
    }()
    
    let nameLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 20)
        return view
    }()
    
    let distanceLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 16)
        return view
    }()
    
    let addressLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 18)
        return view
    }()
    
    let urlButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .lightGray
        view.setTitle("자세히 보기", for: .normal)
        view.isHidden = true
        return view
    }()

    override func configureUI() {
        self.backgroundColor = .systemBackground
        [mapView, infoContainer, nameLabel, distanceLabel, addressLabel, urlButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setContraints() {
        
        infoContainer.snp.makeConstraints { make in
            make.bottom.equalTo(self).offset(20)
            make.leading.trailing.equalTo(self)
            make.height.equalTo(180)
        }
        
        mapView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(infoContainer.snp.top).offset(16)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(infoContainer).inset(20)
            make.leading.equalTo(infoContainer).inset(20)
        }
        
        distanceLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalTo(nameLabel.snp.leading)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(distanceLabel.snp.top)
            make.leading.equalTo(distanceLabel.snp.trailing).offset(16)
        }
        
        urlButton.snp.makeConstraints { make in
            make.top.equalTo(distanceLabel.snp.bottom).offset(8)
            make.leading.equalTo(infoContainer).inset(20)
        }
    }
}
