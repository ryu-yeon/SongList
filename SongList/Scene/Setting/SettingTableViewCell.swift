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
        view.text = "리스트 설정"
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .systemBackground
        [titleLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.leading.equalTo(20)
            make.height.equalTo(self).multipliedBy(0.8)
        }
    }
}
