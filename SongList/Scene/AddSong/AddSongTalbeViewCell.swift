//
//  AddSongTalbeViewCell.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/21.
//

import UIKit

import SnapKit

class AddSongTalbeViewCell: BaseTableViewCell {
    
    let listImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.backgroundColor = .lightGray
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 20)
        return view
    }()
    
    let countLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 18)
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .clear
        [listImageView, countLabel, titleLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        listImageView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self).inset(8)
            make.leading.equalTo(self).inset(16)
            make.width.equalTo(listImageView.snp.height)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.leading.equalTo(listImageView.snp.trailing).offset(16)
            make.trailing.equalTo(countLabel.snp.leading).offset(-16)
        }
        
        countLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.trailing.equalTo(self).inset(16)
        }
    }
}
