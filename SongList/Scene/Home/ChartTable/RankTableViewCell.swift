//
//  RankTableViewCell.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/15.
//

import UIKit

import SnapKit

class RankTableViewCell: BaseTableViewCell {
    
    let rankLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 18)
        return view
    }()
    
    let view: SongView = {
        let view = SongView()
        view.backgroundColor = .clear
        view.albumImage.backgroundColor = .lightGray
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .clear
        [rankLabel, view].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        rankLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.width.equalTo(16)
            make.leading.equalTo(8)
        }
        
        view.snp.makeConstraints { make in
            make.leading.equalTo(rankLabel.snp.trailing)
            make.top.equalTo(self)
            make.trailing.bottom.equalTo(self)
        }
    }
    
}
