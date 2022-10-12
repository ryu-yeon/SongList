//
//  SearchTextTableViewCell.swift
//  SongList
//
//  Created by 유연탁 on 2022/10/12.
//

import UIKit

import SnapKit

class SearchTextTableViewCell: BaseTableViewCell {
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.font  = UIFont(name: "Cafe24Ssurround", size: 16)
        view.textColor = .label
        return view
    }()
    
    let textImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "clock.arrow.circlepath")
        view.tintColor = .systemGray2
        return view
    }()
    
    let textImageView2: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "arrow.up.left")
        view.tintColor = .systemGray2
        return view
    }()
    
    override func configureUI() {
        contentView.backgroundColor = .clear
        [titleLabel, textImageView, textImageView2].forEach {
            contentView.addSubview($0)
        }
        self.selectionStyle = .none
    }
    
    override func setConstraints() {
        textImageView.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.leading.equalTo(self)
            make.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.leading.equalTo(textImageView.snp.trailing).offset(16)
            make.trailing.equalTo(textImageView2.snp.leading).offset(-8)
        }
        
        textImageView2.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.trailing.equalTo(8)
            make.width.height.equalTo(24)
        }
    }
}
