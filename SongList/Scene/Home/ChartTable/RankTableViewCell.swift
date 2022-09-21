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
        view.image = UIImage(systemName: "music.note")
        return view
    }()
    
    let rankLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 18)
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 18)
        return view
    }()
    
    let artistLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        return view
    }()
    
    let numberLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 18)
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .clear
        [albumImageView, rankLabel, titleLabel, artistLabel, numberLabel].forEach {
            self.addSubview($0)
        }
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
            make.top.equalTo(albumImageView.snp.top).offset(4)
            make.leading.equalTo(rankLabel.snp.trailing)
            make.trailing.equalTo(self)
        }
        
        artistLabel.snp.makeConstraints { make in
            make.bottom.equalTo(albumImageView.snp.bottom).offset(-4)
            make.leading.equalTo(rankLabel.snp.trailing)
            make.trailing.equalTo(numberLabel.snp.leading).offset(-8)
        }
        
        numberLabel.snp.makeConstraints { make in
            make.bottom.equalTo(artistLabel.snp.bottom)
            make.trailing.equalTo(self)
        }
    }
}
