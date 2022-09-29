//
//  SongView.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/15.
//

import UIKit

import SnapKit

class SongView: BaseView {
    let albumImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.image = UIImage(systemName: "music.note")
        view.clipsToBounds = true
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
        [albumImageView, titleLabel, numberLabel, brandLabel, artistLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        albumImageView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self).inset(4)
            make.leading.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(albumImageView.snp.width)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(albumImageView.snp.top).offset(8)
            make.leading.equalTo(albumImageView.snp.trailing).offset(8)
            make.trailing.equalTo(self)
        }
        
        artistLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(titleLabel.snp.leading)
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
