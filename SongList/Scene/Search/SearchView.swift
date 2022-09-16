//
//  SearchView.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/13.
//

import UIKit

import SnapKit

class SearchView: BaseView {
    
    let usertextField: UITextField = {
        let view = UITextField()
        view.borderStyle = .line
        view.backgroundColor = .white
        view.placeholder = "노래 제목, 가수이름을 입력해주세요"
        return view
    }()
    
    let searchButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        return view
    }()
    
    let searchTableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .blue
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .systemBackground
        [usertextField, searchButton, searchTableView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setContraints() {
        usertextField.snp.makeConstraints { make in
            make.top.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(48)
        }
        
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(usertextField.snp.top)
            make.leading.equalTo(usertextField.snp.trailing)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-20)
            make.width.height.equalTo(48)
        }
        
        searchTableView.snp.makeConstraints { make in
            make.top.equalTo(usertextField.snp.bottom).offset(20)
            make.leading.equalTo(usertextField.snp.leading)
            make.trailing.equalTo(searchButton.snp.trailing)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-20)
        }
        
    }
}
