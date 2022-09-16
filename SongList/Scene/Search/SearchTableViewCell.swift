//
//  SearchTableViewCell.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/14.
//

import UIKit

import SnapKit

class SearchTableViewCell: BaseTableViewCell {
    
    let songView: SongView = {
        let view = SongView()
        view.albumImage.backgroundColor = .lightGray
        view.titleLabel.text = "Title"
        view.artistLabel.text = "Artist"
        view.numberLabel.text = "123123"
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .clear
        [songView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        songView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(self)
        }
    }    
}
