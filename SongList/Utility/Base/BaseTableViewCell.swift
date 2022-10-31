//
//  BaseTableViewCell.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/09.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("INIT CELL 🟢")
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("DEINIT CELL 🔴")
    }
    
    func configureUI() {
        
    }
    
    func setConstraints() {
        
    }
}
