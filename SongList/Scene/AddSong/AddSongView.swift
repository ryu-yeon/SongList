//
//  AddSongView.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/20.
//

import UIKit

import SnapKit

class AddSongView: BaseView {
    
    let backButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "chevron.left.circle.fill"), for: .normal)
        view.tintColor = .mainColor
        view.contentVerticalAlignment = .fill
        view.contentHorizontalAlignment = .fill
        return view
    }()
    
    let textLabel: UILabel = {
        let view = UILabel()
        view.text = "리스트에 노래 추가"
        view.font  = UIFont(name: "Cafe24Ssurround", size: 32)
        view.textColor = .label
        return view
    }()
    
    let listTableView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .none
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .systemBackground
        [backButton, textLabel, listTableView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        backButton.snp.makeConstraints { make in
            make.centerY.equalTo(textLabel)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.width.height.equalTo(32)
        }
        
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(backButton.snp.trailing).offset(8)
        }
        
        listTableView.snp.makeConstraints { make in
            make.top.equalTo(textLabel.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-20)
        }
    }
}
