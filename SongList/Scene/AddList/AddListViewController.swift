//
//  AddListViewController.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/19.
//

import UIKit

import RealmSwift

class AddListViewController: BaseViewController {
    
    let mainView = AddListView()
    
    var listCount: Int?
    
    var colorString: String?
    
    var listTitle: String = ""
    
    let localRealm = try! Realm()
    
    var tasks: Results<ListRealm>!
    
    
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
    }
    
    override func configure() {
        tasks = localRealm.objects(ListRealm.self)
        
        mainView.okButton.addTarget(self, action: #selector(okButtonClicked), for: .touchUpInside)
        mainView.colorButton.addTarget(self, action: #selector(colorButtonClicked), for: .touchUpInside)
        mainView.titleTextField.placeholder = " 내 리스트 #\(tasks.count + 1)"
    }
    
    @objc func colorButtonClicked() {
        let picker = UIColorPickerViewController()
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    @objc func okButtonClicked() {
        
        listTitle = mainView.titleTextField.text ?? "내 리스트 #\(tasks.count + 1)"
        if listTitle == "" {
            listTitle = "내 리스트 #\(tasks.count + 1)"
        }
        ListRepository().saveList(title: listTitle, color: colorString ?? "#D3D3D3")
        mainView.colorButton.heroID = "listImageView\(tasks.count)"
        navigationController?.popViewController(animated: true)
    }
    
    @objc func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
}

extension AddListViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        mainView.colorButton.backgroundColor = color
        colorString = color.toHexString()
    }
}
