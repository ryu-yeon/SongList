//
//  ListTableViewCell.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/15.
//

import UIKit

import SnapKit
import Hero

protocol CVCellDelegate {
    func selectedCVCell(_ index: Int, vc: UIViewController)
}

class ListTableViewCell: BaseTableViewCell {
    
    var delegate: CVCellDelegate?
    
    let listLabel: UILabel = {
        let view = UILabel()
        view.text = "노래 리스트"
        view.font = .boldSystemFont(ofSize: 24)
        view.textColor = .black
        return view
    }()
    
    let myListButton: UIButton = {
        let view = UIButton()
        view.setTitle("마이", for: .normal)
        view.layer.cornerRadius = 8
        view.backgroundColor = .black
        return view
    }()
    
    let recommandListButton: UIButton = {
        let view = UIButton()
        view.setTitle("추천", for: .normal)
        view.layer.cornerRadius = 8
        view.backgroundColor = .lightGray
        return view
    }()
    
    let listCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 16
        let width = UIScreen.main.bounds.width - 22 - spacing * 2
        
        layout.itemSize = CGSize(width: width / 2.5, height: width / 2.5)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .systemBackground
        return view
    }()
    
    override func configureUI() {
        
        listCollectionView.dataSource = self
        listCollectionView.delegate = self
        listCollectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: ListCollectionViewCell.reusableIdentifier)
        [listLabel, myListButton, recommandListButton, listCollectionView].forEach {
            contentView.addSubview($0)
        }
        
        myListButton.addTarget(self, action: #selector(myListButtonClicked), for: .touchUpInside)
        recommandListButton.addTarget(self, action: #selector(recommandListButtonClicked), for: .touchUpInside)
    }
    
    @objc func myListButtonClicked() {
        print(#function)
        myListButton.backgroundColor = .black
        recommandListButton.backgroundColor = .lightGray
    }
    
    @objc func recommandListButtonClicked() {
        print(#function)
        myListButton.backgroundColor = .lightGray
        recommandListButton.backgroundColor = .black
    }
    
    override func setConstraints() {
        
        listLabel.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.leading.equalTo(28)
            make.height.equalTo(24)
        }
        
        myListButton.snp.makeConstraints { make in
            make.top.equalTo(listLabel.snp.top)
            make.trailing.equalTo(recommandListButton.snp.leading).offset(-8)
            make.width.equalTo(40)
            make.height.equalTo(24)
        }
        
        recommandListButton.snp.makeConstraints { make in
            make.top.equalTo(listLabel.snp.top)
            make.trailing.equalTo(self).offset(-20)
            make.width.equalTo(myListButton.snp.width)
            make.height.equalTo(myListButton.snp.height)
        }
        
        listCollectionView.snp.makeConstraints { make in
            make.top.equalTo(listLabel.snp.bottom).offset(16)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.height.equalTo((UIScreen.main.bounds.width - 22 - 32) / 2.5)
        }
    }
}

extension ListTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.reusableIdentifier, for: indexPath) as? ListCollectionViewCell else { return UICollectionViewCell() }
        cell.isHeroEnabled = true
        cell.heroID = "\(indexPath.item)"
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let delegate = delegate {
            let vc = ListViewController()
            vc.mainView.listImage.heroID = "\(indexPath.item)"
            delegate.selectedCVCell(indexPath.item, vc: vc)
        }
    }
    
}


