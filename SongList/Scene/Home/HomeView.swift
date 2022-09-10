//
//  HomeView.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/09.
//

import UIKit

import SnapKit

class HomeView: BaseView {
    
    let usertextField: UITextField = {
        let view = UITextField()
        view.borderStyle = .line
        view.backgroundColor = .white
        view.placeholder = "노래 제목, 가수이름을 입력해주세요"
        return view
    }()
    
    let chartTableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .blue
        return view
    }()
    

    let themeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 16
        let width = UIScreen.main.bounds.width - 40 - spacing * 3

        layout.itemSize = CGSize(width: width / 2, height: width / 2 * 0.36)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .vertical

        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .systemBackground
        [usertextField, chartTableView, themeCollectionView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setContraints() {
        
        usertextField.snp.makeConstraints { make in
            make.top.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(48)
        }
        
        chartTableView.snp.makeConstraints { make in
            make.top.equalTo(usertextField.snp.bottom).offset(20)
            make.leading.equalTo(usertextField.snp.leading)
            make.trailing.equalTo(usertextField.snp.trailing)
            make.height.equalTo(self).multipliedBy(0.4)
        }
        
        themeCollectionView.snp.makeConstraints { make in
            make.top.equalTo(chartTableView.snp.bottom).offset(20)
            make.leading.equalTo(usertextField.snp.leading)
            make.trailing.equalTo(usertextField.snp.trailing)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-20)
        }
    }
}
