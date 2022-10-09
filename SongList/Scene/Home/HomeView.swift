//
//  HomeView.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/09.
//

import UIKit

import SnapKit

class HomeView: BaseView {
    
    let logoLabel: UILabel = {
        let view = UILabel()
        view.text = "뭐 부르지?"
        view.textColor = .mainColor
        view.font = UIFont(name: "Cafe24Ssurround", size: 32)
        return view
    }()
    
    let settingButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        view.tintColor = .mainColor
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
        [logoLabel, settingButton, searchContainer, searchContainerButton, tableView, searchContainerButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        logoLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(16)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
        }
        
        settingButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-20)
            make.width.height.equalTo(25)
        }
        
        searchContainer.snp.makeConstraints { make in
            make.top.equalTo(logoLabel.snp.bottom).offset(8)
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
