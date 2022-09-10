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
        view.backgroundColor = .gray
        return view
    }()
    
    override func configureUI() {
        [settingTableView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setContraints() {
        settingTableView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
