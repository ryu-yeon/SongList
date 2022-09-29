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
        view.backgroundColor = .systemBackground
        return view
    }()
    
    let nameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Cafe24Ssurround", size: 24)
        view.textColor = .label
        return view
    }()
    
    let distanceLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Cafe24Ssurround", size: 18)
        view.textColor = .label
        return view
    }()
    
    let addressLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Cafe24Ssurround", size: 20)
        view.textColor = .label
        return view
    }()
    
    let urlButton: UIButton = {
        let view = UIButton()
        view.setTitle("자세히 보기", for: .normal)
        view.titleLabel?.font = UIFont(name: "Cafe24Ssurround", size: 24)
        view.backgroundColor = .systemMint
        view.layer.cornerRadius = 20
        view.isHidden = true
        return view
    }()

    override func configureUI() {
        self.backgroundColor = .systemBackground
        [mapView, infoContainer, nameLabel, distanceLabel, addressLabel, urlButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
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
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalTo(nameLabel.snp.leading)
        }
        
        distanceLabel.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(8)
            make.leading.equalTo(nameLabel.snp.leading)
        }
        
        urlButton.snp.makeConstraints { make in
            make.top.equalTo(distanceLabel.snp.top)
            make.trailing.equalTo(infoContainer).inset(20)
            make.width.equalTo(160)
            make.height.equalTo(60)
        }
    }
}
