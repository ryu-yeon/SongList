//
//  RankTableViewCell.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/15.
//

import UIKit

import SnapKit

class RankTableViewCell: BaseTableViewCell {
    
    let albumImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    let rankLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.font = UIFont(name: "Cafe24Ssurround", size: 18)
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Cafe24Ssurround", size: 16)
        view.textColor = .label
        return view
    }()
    
    let artistLabel: UILabel = {
        let view = UILabel()
        view.textColor = .systemGray2
        view.font = UIFont(name: "Cafe24Ssurround", size: 14)
        return view
    }()
    
    let numberLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Cafe24Ssurround", size: 16)
        view.textColor = .label
        return view
    }()
    
    let brandLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Cafe24Ssurround", size: 16)
        view.textColor = .label
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .clear
        [albumImageView, rankLabel, titleLabel, numberLabel, brandLabel, artistLabel].forEach {
            self.addSubview($0)
        }
        
        self.selectionStyle = .none
    }
    
    override func setConstraints() {
        
        albumImageView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self).inset(4)
            make.leading.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(albumImageView.snp.width)
        }
        
        rankLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.width.equalTo(40)
            make.leading.equalTo(albumImageView.snp.trailing)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(albumImageView.snp.top).offset(8)
            make.leading.equalTo(rankLabel.snp.trailing)
            make.trailing.equalTo(self)
        }
        
        artistLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(rankLabel.snp.trailing)
            make.trailing.equalTo(brandLabel.snp.leading).offset(-8)
        }
        
        numberLabel.snp.makeConstraints { make in
            make.bottom.equalTo(artistLabel.snp.bottom)
            make.trailing.equalTo(self)
        }
        
        brandLabel.snp.makeConstraints { make in
            make.bottom.equalTo(numberLabel.snp.bottom)
            make.trailing.equalTo(numberLabel.snp.leading).offset(-4)
        }
    }
}
