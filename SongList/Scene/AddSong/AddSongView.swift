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
        view.font = .systemFont(ofSize: 28)
        return view
    }()
    
    let xButton: UIButton = {
        let view  = UIButton()
        view.setImage(UIImage(systemName: "xmark"), for: .normal)
        return view
    }()
    
    let listTableView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .none
        return view
    }()
    
    let createListButton: UIButton = {
        let view = UIButton()
        view.setTitle("새 리스트 생성", for: .normal)
        view.backgroundColor = .lightGray
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .systemBackground
        [textLabel, xButton, listTableView, createListButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setContraints() {
        
        textLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(self).offset(20)
            make.trailing.equalTo(xButton.snp.leading).inset(16)
            make.height.equalTo(32)
        }
        
        xButton.snp.makeConstraints { make in
            make.top.equalTo(textLabel.snp.top)
            make.trailing.equalTo(self).inset(20)
            make.width.height.equalTo(textLabel.snp.height)
        }
        
        listTableView.snp.makeConstraints { make in
            make.top.equalTo(textLabel.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self)
            make.bottom.equalTo(createListButton.snp.top).offset(-20)
        }
        
        createListButton.snp.makeConstraints { make in
            make.bottom.equalTo(self).inset(20)
            make.trailing.equalTo(xButton.snp.trailing)
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
    }
}