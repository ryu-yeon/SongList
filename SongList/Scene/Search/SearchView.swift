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
        view.backgroundColor = .clear
        view.setImage(UIImage(systemName: "xmark"), for: .normal)
        view.tintColor = .label
        return view
    }()
    
    let searchContainer: SearchContainerView = {
        let view = SearchContainerView()
        return view
    }()
    
    let segmentControl: UISegmentedControl = {
        let view = UISegmentedControl(items: [BrandText.TJ.rawValue, BrandText.KY.rawValue])
        view.selectedSegmentIndex = 0
        view.selectedSegmentTintColor = .mainColor
        view.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Cafe24Ssurround", size: 20)!, NSAttributedString.Key.foregroundColor : UIColor.label], for: .normal)
        view.tintColor = .systemGray4
        return view
    }()
    
    let searchTableView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .singleLine
        view.backgroundColor = .clear
        return view
    }()
    
    let searchTextTableView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .singleLine
        view.backgroundColor = .systemBackground
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .systemBackground
        [searchContainer, segmentControl, searchTableView, xButton, searchTextTableView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
               
        searchContainer.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(80)
        }
        
        xButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-20)
            make.width.height.equalTo(25)
        }
        
        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(searchContainer.snp.bottom).offset(8)
            make.centerX.equalTo(self)
            make.width.equalTo(160)
            make.height.equalTo(40)
        }

        searchTableView.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom).offset(8)
            make.leading.equalTo(searchContainer.snp.leading)
            make.trailing.equalTo(searchContainer.snp.trailing)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        searchTextTableView.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom).offset(8)
            make.leading.equalTo(searchContainer.snp.leading)
            make.trailing.equalTo(searchContainer.snp.trailing)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
