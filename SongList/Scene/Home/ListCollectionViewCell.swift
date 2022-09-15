//
//  ListCollectionViewCell.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/15.
//

import UIKit

import SnapKit

class ListCollectionViewCell: BaseCollectionViewCell {
    
    override func configureUI() {
        self.backgroundColor = .lightGray
        self.layer.cornerRadius = 24
    }
}
