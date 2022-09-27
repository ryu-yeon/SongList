//
//  AddSongView.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/20.
//

import UIKit

import SnapKit

class AddSongView: BaseView {
    
    let textLabel: UILabel = {
        let view = UILabel()
        view.text = "리스트에 노래 추가"
        view.font = .boldSystemFont(ofSize: 28)
        return view
    }()
    
    let listTableView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .none
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .systemBackground
        [textLabel, listTableView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setContraints() {
        
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(40)
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).inset(16)
            make.height.equalTo(32)
        }
        
        listTableView.snp.makeConstraints { make in
            make.top.equalTo(textLabel.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-20)
        }
    }
}
