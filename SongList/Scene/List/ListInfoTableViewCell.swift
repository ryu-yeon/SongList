//
//  ListInfoTableViewCell.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/30.
//

import UIKit

import SnapKit

class ListInfoTableViewCell: BaseTableViewCell {
    
    var listImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    var listTitleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Cafe24Ssurround", size: 24)
        view.textColor = .label
        return view
    }()
    
    var listCountLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Cafe24Ssurround", size: 20)
        view.textColor = .label
        view.textAlignment = .right
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .clear
        [listImageView, listCountLabel, listTitleLabel].forEach {
            contentView.addSubview($0)
        }
        self.selectionStyle = .none
    }
    
    override func setConstraints() {
        listImageView.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.width.height.equalTo(160)
        }
        
        listCountLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self)
            make.trailing.equalTo(self).offset(-8)
            make.width.equalTo(48)
        }
        
        listTitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self)
            make.leading.equalTo(self).offset(8)
            make.trailing.equalTo(listCountLabel.snp.leading).offset(-8)
        }
    }
}
