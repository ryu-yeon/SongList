//
//  SearchView.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/13.
//

import UIKit

import SnapKit

class SearchView: BaseView {
    
    let xButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 8
        view.setImage(UIImage(systemName: "xmark"), for: .normal)
        view.tintColor = .black
        return view
    }()
    
    let searchContainer: SearchContainerView = {
        let view = SearchContainerView()
        return view
    }()
    
    let segmentControl: UISegmentedControl = {
        let view = UISegmentedControl(items: ["TJ", "금영"])
        return view
    }()
    
    let searchTableView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .singleLine
        view.backgroundColor = .clear
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .systemBackground
        [searchContainer, segmentControl, searchTableView, xButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setContraints() {
               
        searchContainer.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(80)
        }
        
        xButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(8)
            make.trailing.equalTo(-20)
            make.height.equalTo(self).multipliedBy(0.06)
            make.width.equalTo(xButton.snp.height)
        }
        
        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(searchContainer.snp.bottom).offset(20)
            make.centerX.equalTo(self)
            make.width.equalTo(160)
            make.height.equalTo(40)
        }

        searchTableView.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom).offset(20)
            make.leading.equalTo(searchContainer.snp.leading)
            make.trailing.equalTo(searchContainer.snp.trailing)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
