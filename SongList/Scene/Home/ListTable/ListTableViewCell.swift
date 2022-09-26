//
//  ListTableViewCell.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/15.
//

import UIKit

import Hero
import RealmSwift
import SnapKit
import Kingfisher

enum ListType {
    case my
    case recommand
}

protocol CVCellDelegate {
    func selectedCVCell(_ index: Int, vc: UIViewController)
}

class ListTableViewCell: BaseTableViewCell {
    
    var delegate: CVCellDelegate?
    
    let localRealm = try! Realm()
    
    var tasks: Results<ListRealm>!
    
    var listType = ListType.my
    
    let data = Data().data
    
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
        
        layout.itemSize = CGSize(width: width / 2.5, height: width / 2.5 + 20)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .systemBackground
        return view
    }()
    
    override func configureUI() {
        
        tasks = localRealm.objects(ListRealm.self)
        
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
        listType = ListType.my
        listCollectionView.reloadData()
        myListButton.backgroundColor = .black
        recommandListButton.backgroundColor = .lightGray
    }
    
    @objc func recommandListButtonClicked() {
        listType = ListType.recommand
        listCollectionView.reloadData()
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
            make.height.equalTo((UIScreen.main.bounds.width - 22 - 32) / 2.5 + 20)
        }
    }
}

extension ListTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if listType == ListType.my {
            return tasks.count + 1
        } else {
            return data.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.reusableIdentifier, for: indexPath) as? ListCollectionViewCell else { return UICollectionViewCell() }
        
        if listType == ListType.my {
            
            if indexPath.item < tasks.count {
                cell.isHeroEnabled = true
                cell.heroID = "listImageView\(indexPath.item)"
                cell.listImageView.backgroundColor =
                UIColor(hexFromString: tasks[indexPath.item].color)
                cell.listTitleLabel.text = tasks[indexPath.row].title
            } else {
                cell.isHeroEnabled = true
                cell.heroID = "listImageView\(indexPath.item)"
                cell.listImageView.image = UIImage(systemName: "plus")
                cell.listImageView.backgroundColor = .white
                cell.tintColor = .black
                cell.listImageView.layer.borderColor = UIColor.darkGray.cgColor
                cell.listImageView.layer.borderWidth = 1
                cell.listTitleLabel.text = "리스트 추가"
            }
        } else {
            let url = URL(string: data[indexPath.row].image)
            cell.listImageView.kf.setImage(with: url)
            cell.listTitleLabel.text = data[indexPath.row].title
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if listType == ListType.my {
            if let delegate = delegate {
                if indexPath.item < tasks.count{
                    let vc = ListViewController()
                    vc.mainView.listImage.heroID = "listImageView\(indexPath.item)"
                    vc.task = self.tasks?[indexPath.item]
                    delegate.selectedCVCell(indexPath.item, vc: vc)
                    
                } else {
                    let vc = AddListViewController()
                    vc.mainView.colorButton.heroID = "listImageView\(indexPath.item)"
                    delegate.selectedCVCell(indexPath.item, vc: vc)
                }
            }
        } else {
            if let delegate = delegate {
                let vc = ListViewController()
                vc.mainView.listImage.heroID = "listImageView\(indexPath.item)"
                vc.songList = data[indexPath.item]
                delegate.selectedCVCell(indexPath.item, vc: vc)
                
            }
        }
    }
}


