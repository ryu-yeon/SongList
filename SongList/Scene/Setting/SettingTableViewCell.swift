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
    
    override func configureUI() {
        self.backgroundColor = .systemBackground
        [titleLabel, detailLabel].forEach {
            self.addSubview($0)
        }
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
        
    }
}
