//
//  ListCollectionViewCell.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/15.
//

import UIKit

import SnapKit

class ListCollectionViewCell: BaseCollectionViewCell {
    
    let listTitleLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16)
        view.numberOfLines = 1
        view.textAlignment = .center
        return view
    }()
    
    var listImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 24
        view.clipsToBounds = true
        return view
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        listImageView.image = nil
        listImageView.layer.borderWidth = 0
    }
    
    override func configureUI() {
        
        [listTitleLabel, listImageView].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        listImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self)
            make.height.equalTo(listImageView.snp.width)
        }
        
        listTitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self)
            make.leading.trailing.equalTo(self)
        }
    }
}
