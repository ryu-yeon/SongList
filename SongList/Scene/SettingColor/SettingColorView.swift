//
//  SettingColorView.swift
//  SongList
//
//  Created by 유연탁 on 2022/10/09.
//

import UIKit

import SnapKit

class SettingColorView: BaseView {
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "변경할 색상을 선택해주세요."
        view.font  = UIFont(name: "Cafe24Ssurround", size: 28)
        return view
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - spacing * 6 - 40
        
        layout.itemSize = CGSize(width: width / 5, height: width / 5)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.isScrollEnabled = false
        return view
    }()
    
    let okButton: UIButton = {
        let view = UIButton()
        view.setTitle("변경하기", for: .normal)
        view.setTitleColor(UIColor.label, for: .normal)
        view.titleLabel?.font  = UIFont(name: "Cafe24Ssurround", size: 24)
        view.backgroundColor = .mainColor
        view.layer.cornerRadius = 12
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .systemBackground
        [titleLabel, collectionView, okButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.centerX.equalTo(self)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(self).inset(20)
            make.height.equalTo(((UIScreen.main.bounds.width - 8 * 6 - 40) / 5 + 16) * 2)
        }
        
        okButton.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(16)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(52)
        }
    }
    
}
