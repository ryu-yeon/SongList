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
        view.backgroundColor = .lightGray
        view.setTitle("제목검색", for: .normal)
        view.tintColor = .black
        view.layer.cornerRadius = 8
        return view
    }()
    
    let artistSearchButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .lightGray
        view.setTitle("가수검색", for: .normal)
        view.tintColor = .black
        view.layer.cornerRadius = 8
        return view
    }()
    
    let searchContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        return view
    }()
    
    let userTextField: UITextField = {
        let view = UITextField()
        view.borderStyle = .none
        view.backgroundColor = .white
        view.placeholder = "입력해주세요"
        return view
    }()
    
    let searchButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .lightGray
        view.tintColor = .white
        view.layer.cornerRadius = 8
        view.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .clear
        [songSearchButton, artistSearchButton, searchContainer, userTextField, searchButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setContraints() {
        songSearchButton.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.leading.equalTo(self)
            make.width.equalTo(80)
            make.height.equalTo(25)
        }
        
        artistSearchButton.snp.makeConstraints { make in
            make.top.equalTo(songSearchButton.snp.top)
            make.leading.equalTo(songSearchButton.snp.trailing).offset(8)
            make.width.equalTo(songSearchButton.snp.width)
            make.height.equalTo(songSearchButton.snp.height)
        }
        
        searchContainer.snp.makeConstraints { make in
            make.top.equalTo(songSearchButton.snp.bottom).offset(8)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.height.equalTo(48)
        }
        
        userTextField.snp.makeConstraints { make in
            make.top.equalTo(searchContainer.snp.top).inset(2)
            make.bottom.equalTo(searchContainer.snp.bottom).inset(2)
            make.leading.equalTo(searchContainer.snp.leading).inset(16)
            make.trailing.equalTo(searchButton.snp.leading)
        }

        searchButton.snp.makeConstraints { make in
            make.top.equalTo(searchContainer.snp.top).inset(4)
            make.bottom.equalTo(searchContainer.snp.bottom).inset(4)
            make.trailing.equalTo(searchContainer.snp.trailing).inset(8)
            make.width.equalTo(40)
        }
    }
}
