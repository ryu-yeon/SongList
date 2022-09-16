//
//  BaseView.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/09.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        
    }
    
    func setContraints() {
        
    }
}
