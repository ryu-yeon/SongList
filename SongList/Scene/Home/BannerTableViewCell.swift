//
//  BannerTableViewCell.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/15.
//

import UIKit

import SnapKit

class BannerTableViewCell: BaseTableViewCell {
  
    let bannerLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Cafe24Ssurround", size: 24)
        view.textColor = .label
        return view
    }()
    
    let bannerButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 10
        return view
    }()
    
    
    override func configureUI() {
        [bannerLabel, bannerButton].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        bannerLabel.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.leading.equalTo(20)
            make.height.equalTo(28)
        }
        
        bannerButton.snp.makeConstraints { make in
            make.top.equalTo(bannerLabel.snp.bottom).offset(16)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(120)
        }
    }

}
