//
//  AddListView.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/19.
//

import UIKit

import SnapKit

class AddListView: BaseView {
        
    let listImageView: UIImageView = {
        let view = UIImageView()
        view.layer.borderColor = UIColor.label.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    let colorButton: UIButton = {
        let view = UIButton()
        return view
    }()
    
    let colorTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "리스트 커버 색상을 지정하세요."
        view.font = UIFont(name: "Cafe24Ssurround", size: 22)
        view.textColor = .label
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "리스트의 이름을 지정하세요."
        view.font = UIFont(name: "Cafe24Ssurround", size: 22)
        view.textColor = .label
        return view
    }()
    
    let titleTextField: UITextField = {
        let view = UITextField()
        view.borderStyle = .line
        return view
    }()
    
    let iconLabel: UILabel = {
        let view = UILabel()
        view.text = "리스트 커버 아이콘을 검색하세요."
        view.font = UIFont(name: "Cafe24Ssurround", size: 22)
        view.textColor = .label
        return view
    }()
    
    let iconTextField: UITextField = {
        let view = UITextField()
        view.borderStyle = .line
        return view
    }()
    
    let searchButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        view.tintColor = .mainColor
        return view
    }()
    
    let iconCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - spacing * 6 - 40
        
        layout.itemSize = CGSize(width: width / 5, height: width / 5)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .systemGray5
        return view
    }()
    
    let okButton:UIButton = {
        let view = UIButton()
        view.setTitle("만들기", for: .normal)
        view.setTitleColor(UIColor.label, for: .normal)
        view.titleLabel?.font  = UIFont(name: "Cafe24Ssurround", size: 20)
        view.backgroundColor = .mainColor
        view.layer.cornerRadius = 12
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .systemBackground
        [listImageView, colorTitleLabel, colorButton, titleLabel, titleTextField, iconLabel, iconTextField, searchButton, iconCollectionView, okButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        colorTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(8)
            make.leading.trailing.equalTo(self).inset(20)
        }
        
        listImageView.snp.makeConstraints { make in
            make.top.equalTo(colorTitleLabel.snp.bottom).offset(8)
            make.centerX.equalTo(self)
            make.width.height.equalTo(120)
        }
        
        colorButton.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(listImageView).inset(0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(colorButton.snp.bottom).offset(16)
            make.leading.trailing.equalTo(self).inset(20)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(self).inset(20)
            make.height.equalTo(48)
        }
        
        iconLabel.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(16)
            make.leading.trailing.equalTo(self).inset(20)
        }
        
        iconTextField.snp.makeConstraints { make in
            make.top.equalTo(iconLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(self).inset(20)
            make.height.equalTo(48)
        }
        
        searchButton.snp.makeConstraints { make in
            make.top.trailing.bottom.equalTo(iconTextField).inset(4)
            make.width.equalTo(searchButton.snp.height)
        }
        
        iconCollectionView.snp.makeConstraints { make in
            make.top.equalTo(iconTextField.snp.bottom).offset(8)
            make.leading.trailing.equalTo(self).inset(20)
            make.height.equalTo(((UIScreen.main.bounds.width - 8 * 6 - 40) / 5 + 16) * 2)
        }
        
        okButton.snp.makeConstraints { make in
            make.top.equalTo(iconCollectionView.snp.bottom).offset(16)
            make.centerX.equalTo(self)
            make.leading.trailing.equalTo(self).inset(20)
            make.height.equalTo(52)
        }
    }
}
    
