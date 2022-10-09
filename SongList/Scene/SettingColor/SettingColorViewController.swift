//
//  SettingColorViewController.swift
//  SongList
//
//  Created by 유연탁 on 2022/10/09.
//

import UIKit

import PanModal
import Toast

class SettingColorViewController: BaseViewController {
    
    private let mainView = SettingColorView()
    
    var selectIndexPath: IndexPath = IndexPath(item: 0, section: 0)
    
    let colorList: [UIColor] = [.systemMint, .systemPink, .systemBlue, .systemYellow, .systemRed, .systemOrange, .systemBrown, .systemGreen,.systemPurple, .systemIndigo]
    
    var selectColor: UIColor?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configure() {
     
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.register(AddListCollectionViewCell.self, forCellWithReuseIdentifier: AddListCollectionViewCell.reusableIdentifier)
        
        mainView.okButton.addTarget(self, action: #selector(okButtonClicked), for: .touchUpInside)
    }
    
    @objc func okButtonClicked() {
        UserDefaults.standard.setColor(color: selectColor, forKey: "color")
        UIColor.mainColor = UserDefaults.standard.colorForKey(key: "color") ?? .systemMint
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        let nav = UINavigationController(rootViewController: HomeViewController())
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKeyAndVisible()
        
        nav.view.makeToast("색상이 변경되었습니다.", duration: 1.0, position: .bottom)
    }
}

extension SettingColorViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddListCollectionViewCell.reusableIdentifier, for: indexPath) as? AddListCollectionViewCell else { return UICollectionViewCell() }
        
        cell.iconImageView.backgroundColor = colorList[indexPath.item]
        cell.iconImageView.layer.borderWidth = selectIndexPath == indexPath ? 4 : 0
        cell.iconImageView.layer.borderColor = selectIndexPath == indexPath ? UIColor.black.cgColor : nil
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectIndexPath = indexPath
        selectColor = colorList[indexPath.item]
        collectionView.reloadData()
    }

}
extension SettingColorViewController: PanModalPresentable {
    
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(300)
    }
    
    var longFormHeight: PanModalHeight {
        return .contentHeight(300)
    }
}
