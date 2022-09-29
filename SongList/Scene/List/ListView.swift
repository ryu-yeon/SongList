//
//  ListView.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/16.
//

import UIKit

import SnapKit

class ListView: BaseView {
    
    let listTableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .systemBackground
        self.addSubview(listTableView)
    }
    
    override func setContraints() {
        listTableView.snp.makeConstraints { make in
            make.top.equalTo(self).offset(-40)
            make.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
