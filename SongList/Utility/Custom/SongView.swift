//
//  SongView.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/15.
//

import UIKit

import SnapKit

class SongView: BaseView {
    let albumImage: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 8
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
        [albumImage, titleLabel, numberLabel, artistLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func setContraints() {
        albumImage.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.leading.equalTo(self).offset(8)
            make.width.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(albumImage.snp.top)
            make.leading.equalTo(albumImage.snp.trailing).offset(16)
        }
        
        artistLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(numberLabel.snp.leading).offset(-8)
            make.bottom.equalTo(albumImage.snp.bottom)
        }
        
        numberLabel.snp.makeConstraints { make in
            make.trailing.equalTo(self).offset(-8)
            make.bottom.equalTo(albumImage.snp.bottom)
        }
    }
}
