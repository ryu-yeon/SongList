//
//  BaseCollectionViewCell.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/09.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("INIT ITEM 🟢")
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("DEINIT ITEM 🔴")
    }
    
    func configureUI() {
        
    }
    
    func setConstraints() {
        
    }
    
}
