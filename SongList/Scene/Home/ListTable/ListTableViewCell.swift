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

protocol CVCellDelegate: AnyObject {
    func selectedCVCell(_ index: Int, vc: UIViewController)
}

class ListTableViewCell: BaseTableViewCell {
    
    weak var delegate: CVCellDelegate?
    
    let listRepository = ListRepository()
    
    var tasks: Results<ListRealm>!
    
    var listType = ListType.my
    
    let data = SongData().data
    
    let listLabel: UILabel = {
        let view = UILabel()
        view.text = Menu.first.rawValue
        view.font = UIFont(name: "Cafe24Ssurround", size: 24)
        view.textColor = .label
        return view
    }()
    
    let myListButton: UIButton = {
        let view = UIButton()
        view.setTitle(ListType.my.rawValue, for: .normal)
        view.titleLabel?.font = UIFont(name: "Cafe24Ssurround", size: 16)
        view.setTitleColor(UIColor.systemBackground, for: .normal)
        view.layer.cornerRadius = 8
        view.backgroundColor = .mainColor
        return view
    }()
    
    let recommandListButton: UIButton = {
        let view = UIButton()
        view.setTitle(ListType.recommand.rawValue, for: .normal)
        view.titleLabel?.font = UIFont(name: "Cafe24Ssurround", size: 16)
        view.setTitleColor(UIColor.label, for: .normal)
        view.layer.cornerRadius = 8
        view.backgroundColor = .systemGray4
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
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    override func configureUI() {
        tasks = listRepository.fetch()
        
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
        myListButton.backgroundColor = .mainColor
        myListButton.setTitleColor(UIColor.systemBackground, for: .normal)
        recommandListButton.backgroundColor = .systemGray4
        recommandListButton.setTitleColor(UIColor.label, for: .normal)
    }
    
    @objc func recommandListButtonClicked() {
        listType = ListType.recommand
        listCollectionView.reloadData()
        myListButton.backgroundColor = .systemGray4
        myListButton.setTitleColor(UIColor.label, for: .normal)
        recommandListButton.backgroundColor = .mainColor
        recommandListButton.setTitleColor(UIColor.systemBackground, for: .normal)
    }
    
    override func setConstraints() {
        
        listLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalTo(20)
            make.width.equalTo(140)
            make.height.equalTo(28)
        }
        
        myListButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.trailing.equalTo(recommandListButton.snp.leading).offset(-8)
            make.width.equalTo(40)
            make.height.equalTo(24)
        }
        
        recommandListButton.snp.makeConstraints { make in
            make.top.equalTo(myListButton.snp.top)
            make.trailing.equalTo(self).offset(-20)
            make.width.equalTo(myListButton.snp.width)
            make.height.equalTo(myListButton.snp.height)
        }
        
        listCollectionView.snp.makeConstraints { make in
            make.top.equalTo(listLabel.snp.bottom)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.height.equalTo((UIScreen.main.bounds.width - 22 - 32) / 2.5 + 20 + 16)
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
                let url = URL(string: tasks[indexPath.item].image)
                cell.listImageView.kf.setImage(with: url)
            } else {
                cell.isHeroEnabled = true
                cell.heroID = "listImageView\(indexPath.item)"
                cell.listImageView.image = UIImage(systemName: "plus")
                cell.listImageView.backgroundColor = .white
                cell.tintColor = .darkGray
                cell.listImageView.layer.borderColor = UIColor.darkGray.cgColor
                cell.listImageView.layer.borderWidth = 1
                cell.listTitleLabel.text = "리스트 추가"
            }
        } else {
            cell.heroID = "listImageView\(indexPath.item)"
            let url = URL(string: data[indexPath.row].image)
            cell.listImageView.kf.setImage(with: url)
            cell.listImageView.backgroundColor = .systemGray3
            cell.listTitleLabel.text = data[indexPath.row].title
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if listType == ListType.my {
            if let delegate = delegate {
                if indexPath.item < tasks.count{
                    let vc = ListViewController()
                    vc.task = self.tasks?[indexPath.item]
                    vc.number = indexPath.item
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
                vc.number = indexPath.item
                vc.songList = data[indexPath.item]
                delegate.selectedCVCell(indexPath.item, vc: vc)
            }
        }
    }
}


