//
//  ListView.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/16.
//

import UIKit

import SnapKit

class ListView: BaseView {
    
    let listImage: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 10
        return view
    }()
    
    let listTableView: UITableView = {
        let view = UITableView()
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .systemBackground
        [listImage, listTableView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setContraints() {
        listImage.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.centerX.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.5)
            make.height.equalTo(listImage.snp.width)
        }
        
        listTableView.snp.makeConstraints { make in
            make.top.equalTo(listImage.snp.bottom).offset(20)
            make.bottom.leading.trailing.equalTo(self)
        }
    }
}
