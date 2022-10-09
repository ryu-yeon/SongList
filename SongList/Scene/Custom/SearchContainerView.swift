//
//  SearchContainerView.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/16.
//

import UIKit

import SnapKit

class SearchContainerView: BaseView {
    
    let songSearchButton: UIButton = {
        let view = UIButton()
        view.setTitle("제목검색", for: .normal)
        view.setTitleColor(UIColor.mainColor, for: .normal)
        view.titleLabel?.font = UIFont(name: "Cafe24Ssurround", size: 15)
        return view
    }()
    
    let songSearchLine: UIView = {
        let view = UIView()
        view.backgroundColor = .mainColor
        return view
    }()
    
    let artistSearchButton: UIButton = {
        let view = UIButton()
        view.setTitle("가수검색", for: .normal)
        view.setTitleColor(UIColor.systemGray4, for: .normal)
        view.titleLabel?.font = UIFont(name: "Cafe24Ssurround", size: 15)
        view.tintColor = .label
        return view
    }()
    
    let artistSearchLine: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        return view
    }()
    
    let searchContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.mainColor.cgColor
        return view
    }()
    
    let userTextField: UITextField = {
        let view = UITextField()
        view.borderStyle = .none
        view.backgroundColor = .clear
        return view
    }()
    
    let searchButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        view.tintColor = .mainColor
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .clear
        [songSearchButton, songSearchLine, artistSearchButton, artistSearchLine, searchContainer, userTextField, searchButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        songSearchButton.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.leading.equalTo(self)
            make.width.equalTo(64)
            make.height.equalTo(20)
        }
        
        songSearchLine.snp.makeConstraints { make in
            make.top.equalTo(songSearchButton.snp.bottom).offset(1)
            make.leading.trailing.equalTo(songSearchButton)
            make.height.equalTo(1)
        }
        
        artistSearchButton.snp.makeConstraints { make in
            make.top.equalTo(songSearchButton.snp.top)
            make.leading.equalTo(songSearchButton.snp.trailing).offset(12)
            make.width.equalTo(songSearchButton.snp.width)
            make.height.equalTo(songSearchButton.snp.height)
        }
        
        artistSearchLine.snp.makeConstraints { make in
            make.top.equalTo(artistSearchButton.snp.bottom).offset(1)
            make.leading.trailing.equalTo(artistSearchButton)
            make.height.equalTo(1)
        }
        
        searchContainer.snp.makeConstraints { make in
            make.top.equalTo(songSearchLine.snp.bottom).offset(8)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.height.equalTo(40)
        }
        
        userTextField.snp.makeConstraints { make in
            make.top.bottom.equalTo(searchContainer).inset(4)
            make.leading.equalTo(searchContainer).inset(16)
            make.trailing.equalTo(searchContainer).inset(20)
        }

        searchButton.snp.makeConstraints { make in
            make.top.equalTo(searchContainer.snp.top).inset(4)
            make.bottom.equalTo(searchContainer.snp.bottom).inset(4)
            make.trailing.equalTo(searchContainer.snp.trailing).inset(8)
            make.width.equalTo(40)
        }
    }
}
