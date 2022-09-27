//
//  HomeView.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/09.
//

import UIKit

import SnapKit

class HomeView: BaseView {
    
    let logoImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 10
        return view
    }()
    
    let settingButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        view.tintColor = .black
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 8
        return view
    }()
    
    let searchContainer: SearchContainerView = {
        let view = SearchContainerView()
        return view
    }()
    
    let searchContainerButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .clear
        return view
    }()
    
    
    let tableView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .none
        return view
    }()

    override func configureUI() {
        self.backgroundColor = .systemBackground
        [logoImageView, settingButton, searchContainer, searchContainerButton, tableView, searchContainerButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setContraints() {
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(8)
            make.centerX.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.4)
            make.height.equalTo(self).multipliedBy(0.06)
        }
        
        settingButton.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.top)
            make.leading.equalTo(self).offset(20)
            make.width.height.equalTo(logoImageView.snp.height)
        }
        
        searchContainer.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(20)
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.height.equalTo(80)
        }
        
        searchContainerButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(searchContainer).inset(0)
            make.height.equalTo(48)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchContainer.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(self)
        }
    }
}
