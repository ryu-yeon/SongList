//
//  AddListCollectionViewCell.swift
//  SongList
//
//  Created by 유연탁 on 2022/10/02.
//

import UIKit

import SnapKit

class AddListCollectionViewCell: BaseCollectionViewCell {
    let iconImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .clear
        contentView.addSubview(iconImageView)
    }
    
    override func setConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide).inset(0)
        }
    }
}
