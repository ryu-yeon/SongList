//
//  SettingTableViewCell.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/10.
//

import UIKit

import SnapKit

class SettingTableViewCell: BaseTableViewCell {
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Cafe24Ssurround", size: 20)
        view.textColor = .label
        return view
    }()
    
    let detailLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Cafe24Ssurround", size: 16)
        view.textColor = .label
        return view
    }()
    
    let detailImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right.circle.fill")
        view.tintColor = .mainColor
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .systemBackground
        [titleLabel, detailLabel, detailImageView].forEach {
            self.addSubview($0)
        }
        self.selectionStyle = .none
    }
    
    override func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.leading.equalTo(20)
            make.height.equalTo(self).multipliedBy(0.8)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self).inset(10)
            make.trailing.equalTo(self).inset(20)
        }
        
        detailImageView.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.trailing.equalTo(self).inset(20)
        }
        
    }
}
