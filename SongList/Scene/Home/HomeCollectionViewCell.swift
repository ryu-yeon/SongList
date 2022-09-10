//
//  HomeCollectionViewCell.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/09.
//

import UIKit

import SnapKit

class HomeCollectionViewCell: BaseCollectionViewCell {
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "최신곡"
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .gray
        [titleLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.leading.equalTo(20)
            make.height.equalTo(self).multipliedBy(0.8)
        }
    }
}
