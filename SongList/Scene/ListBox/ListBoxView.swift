//
//  ListBoxView.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/10.
//

import UIKit

import SnapKit

class ListBoxView: BaseView {
    
    let listBoxCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        let width = UIScreen.main.bounds.width - spacing * 3
        
        layout.itemSize = CGSize(width: width / 2, height: width / 2 * 1.5)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()

    
    override func configureUI() {
        self.backgroundColor = .systemBackground
        [listBoxCollectionView].forEach {
            self.addSubview($0)
        }
    }
    
    
    override func setContraints() {
        listBoxCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
