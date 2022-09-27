//
//  ListView.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/16.
//

import UIKit

import SnapKit

class ListView: BaseView {
    
    var listImage: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    var listTitleLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 20)
        return view
    }()
    
    let listTableView: UITableView = {
        let view = UITableView()
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .systemBackground
        [listImage, listTitleLabel, listTableView].forEach {
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
        
        listTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(listImage.snp.bottom).offset(20)
            make.leading.equalTo(36)
            make.height.equalTo(24)
        }
        
        listTableView.snp.makeConstraints { make in
            make.top.equalTo(listTitleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self).inset(20)
            make.bottom.equalTo(self)
        }
    }
}
