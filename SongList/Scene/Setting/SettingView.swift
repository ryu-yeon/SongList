//
//  SettingView.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/10.
//

import UIKit

import SnapKit

class SettingView: BaseView {
    
    let settingTableView: UITableView = {
        let view = UITableView()
        view.isScrollEnabled = false
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .systemBackground
        [settingTableView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        settingTableView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
