//
//  AddListViewController.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/19.
//

import UIKit

import Kingfisher
import PanModal
import RealmSwift
import Toast

class AddListViewController: BaseViewController {
    
    let mainView = AddListView()
    
    var listCount: Int?
    
    var colorString: String?
    
    var listTitle: String = ""
    
    var listIcon: String = ""
    
    var iconList: [String] = []
    
    var selectIndexPath: IndexPath?
    
    let listRepository = ListRepository()
    
    var token = ""
    
    var tasks: Results<ListRealm>!
    
    var task: ListRealm!
    
    var isNew = true
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image:  UIImage(systemName: "chevron.left.circle.fill"), style: .plain, target: self, action: #selector(backButtonClicked))
        
        FlatIconAPIManager.shared.requestToken { [weak self] token in
            self?.token = token
        }
    }
    
    override func configure() {
        tasks = listRepository.fetch()
        
        mainView.iconCollectionView.delegate = self
        mainView.iconCollectionView.dataSource = self
        mainView.titleTextField.delegate = self
        mainView.iconTextField.delegate = self
        
        mainView.iconCollectionView.register(AddListCollectionViewCell.self, forCellWithReuseIdentifier: AddListCollectionViewCell.reusableIdentifier)
        mainView.okButton.addTarget(self, action: #selector(okButtonClicked), for: .touchUpInside)
        mainView.colorButton.addTarget(self, action: #selector(colorButtonClicked), for: .touchUpInside)
        mainView.titleTextField.placeholder = " 내 리스트 #\(tasks.count + 1)"
        mainView.iconTextField.placeholder = " 영어로 검색해주세요. (ex. heart, dog, cat)"
        
        mainView.searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func colorButtonClicked() {
        self.view.endEditing(true)
        let picker = UIColorPickerViewController()
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    @objc func searchButtonClicked() {
        searchIcon()
        self.view.endEditing(true)
    }
    
    @objc func okButtonClicked() {
        if isNew == true {
            listTitle = mainView.titleTextField.text ?? "내 리스트 #\(tasks.count + 1)"
            if listTitle == "" {
                listTitle = "내 리스트 #\(tasks.count + 1)"
            }
            listRepository.saveList(title: listTitle, color: colorString ?? "#D3D3D3", image: listIcon)
            mainView.colorButton.heroID = "listImageView\(tasks.count)"
            navigationController?.popViewController(animated: true)
        } else {
            
            let alert = UIAlertController(title: nil, message: "리스트 커버를 수정하시겠습니까?", preferredStyle: .alert)
            
            let edit = UIAlertAction(title: "수정", style: .destructive) { _ in
                
                self.listRepository.updateList(task: self.task, title: self.mainView.titleTextField.text ?? self.task.title, color: self.colorString ?? "#D3D3D3", image: self.listIcon)

                self.navigationController?.popViewController(animated: true)
                }
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            
            alert.addAction(cancel)
            alert.addAction(edit)
            self.present(alert, animated: true)
        }
    }
    
    @objc func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    func searchIcon() {
        if let text = mainView.iconTextField.text, text != "" {
                FlatIconAPIManager.shared.requestIcon(text: text, token: self.token) { [weak self] iconList in
                    self?.iconList = iconList
                    DispatchQueue.main.async { [weak self] in
                        self?.mainView.iconCollectionView.reloadData()
                }
            }
        }
    }
    
    func setListCover() {
        colorString = task.color
        mainView.listImageView.backgroundColor = UIColor(hexFromString: colorString ?? "#D3D3D3")
        listIcon = task.image
        let url = URL(string: listIcon)
        mainView.listImageView.kf.setImage(with: url)
        mainView.titleTextField.text = task.title
        mainView.okButton.setTitle("수정하기", for: .normal)
    }
}

extension AddListViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        mainView.listImageView.backgroundColor = color
        colorString = color.toHexString()
    }
}

extension AddListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iconList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddListCollectionViewCell.reusableIdentifier, for: indexPath) as? AddListCollectionViewCell else { return UICollectionViewCell() }
        
        let url = URL(string: iconList[indexPath.item])
        cell.iconImageView.kf.setImage(with: url)
        cell.iconImageView.layer.borderWidth = selectIndexPath == indexPath ? 4 : 0
        cell.iconImageView.layer.borderColor = selectIndexPath == indexPath ? UIColor.red.cgColor : nil
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        listIcon = iconList[indexPath.item]
        let url = URL(string: listIcon)
        mainView.listImageView.kf.setImage(with: url)
        selectIndexPath = indexPath
        collectionView.reloadData()
    }
}

extension AddListViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == mainView.iconTextField {
            self.searchIcon()
        }
        self.view.endEditing(true)
        return true
    }
}
