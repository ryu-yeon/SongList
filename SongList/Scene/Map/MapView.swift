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
    
    let backButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "chevron.left.circle.fill"), for: .normal)
        view.tintColor = .mainColor
        view.contentVerticalAlignment = .fill
        view.contentHorizontalAlignment = .fill
        return view
    }()
    
    let mapLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Cafe24Ssurround", size: 32)
        view.textColor = .label
        view.text = Menu.thrid.rawValue
        return view
    }()
    
    let mapView: NMFMapView = {
        let view = NMFMapView()
        return view
    }()
    
    let currentButton: UIButton = {
        let view = UIButton()
        view.layer.cornerRadius = 12
        view.backgroundColor = .white
        return view
    }()
    
    let currentImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "precision")
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
    
    let normalView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.layer.cornerRadius = 8
        return view
    }()
    
    let normalLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Cafe24Ssurround", size: 12)
        view.textColor = .label
        view.text = "일반"
        return view
    }()
    
    let coinView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemOrange
        view.layer.cornerRadius = 8
        return view
    }()
    
    let coinLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Cafe24Ssurround", size: 12)
        view.textColor = .label
        view.text = "코인"
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
        view.backgroundColor = .mainColor
        view.layer.cornerRadius = 20
        view.isHidden = true
        return view
    }()

    override func configureUI() {
        self.backgroundColor = .systemBackground
        [backButton, mapLabel, mapView, currentButton, currentImageView,infoContainer, nameLabel, distanceLabel, addressLabel, urlButton, normalView, normalLabel, coinView, coinLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        backButton.snp.makeConstraints { make in
            make.centerY.equalTo(mapLabel)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.width.height.equalTo(28)
        }
        
        mapLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(backButton.snp.trailing).offset(8)
        }
        
        infoContainer.snp.makeConstraints { make in
            make.bottom.equalTo(self).offset(20)
            make.leading.trailing.equalTo(self)
            make.height.equalTo(180)
        }
        
        mapView.snp.makeConstraints { make in
            make.top.equalTo(mapLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(infoContainer.snp.top).offset(16)
        }
        
        currentButton.snp.makeConstraints { make in
            make.leading.equalTo(mapView).inset(20)
            make.bottom.equalTo(mapView).inset(40)
            make.width.height.equalTo(40)
        }
        
        currentImageView.snp.makeConstraints { make in
            make.center.equalTo(currentButton)
            make.width.height.equalTo(28)
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
            make.bottom.equalTo(self).offset(-20)
            make.trailing.equalTo(infoContainer).inset(20)
            make.width.equalTo(160)
        }
        
        normalLabel.snp.makeConstraints { make in
            make.top.equalTo(mapLabel.snp.top)
            make.trailing.equalTo(mapView.snp.trailing).offset(-8)
        }
        
        normalView.snp.makeConstraints { make in
            make.centerY.equalTo(normalLabel)
            make.trailing.equalTo(normalLabel.snp.leading).offset(-8)
            make.width.height.equalTo(16)
        }
        
        coinLabel.snp.makeConstraints { make in
            make.top.equalTo(normalLabel.snp.bottom).offset(8)
            make.trailing.equalTo(normalLabel)
        }
        
        coinView.snp.makeConstraints { make in
            make.centerY.equalTo(coinLabel)
            make.trailing.equalTo(coinLabel.snp.leading).offset(-8)
            make.width.height.equalTo(16)
        }
    }
}
