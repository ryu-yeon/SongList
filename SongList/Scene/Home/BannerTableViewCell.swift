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
    
    let bannerImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right.circle.fill")
        view.tintColor = .mainColor
        return view
    }()
    
    let bannerViewButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .systemGray4
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    let bannerButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .clear
        return view
    }()
    
    
    override func configureUI() {
        contentView.backgroundColor = .clear
        [bannerLabel, bannerImageView, bannerButton, bannerViewButton].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        bannerLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalTo(bannerButton).inset(0)
        }
        
        bannerImageView.snp.makeConstraints { make in
            make.leading.equalTo(bannerLabel.snp.trailing).offset(8)
            make.centerY.equalTo(bannerButton)
            make.width.height.equalTo(28)
        }
        
        bannerButton.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.leading.equalTo(20)
            make.width.equalTo(230)
            make.height.equalTo(28)
        }
        
        bannerViewButton.snp.makeConstraints { make in
            make.top.equalTo(bannerLabel.snp.bottom).offset(16)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(bannerViewButton.snp.width).multipliedBy(0.35)
        }
    }
}
