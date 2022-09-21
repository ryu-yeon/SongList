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
    
    var colorString = ""
    
    let localRealm = try! Realm()
    
    var tasks: Results<ListRealm>!
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configure() {
        tasks = localRealm.objects(ListRealm.self)
        
        mainView.okButton.addTarget(self, action: #selector(okButtonClicked), for: .touchUpInside)
        mainView.colorButton.addTarget(self, action: #selector(colorButtonClicked), for: .touchUpInside)
        mainView.titleTextField.placeholder = "내 리스트 #\(tasks.count + 1)"
    }
    
    @objc func colorButtonClicked() {
        let picker = UIColorPickerViewController()
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    @objc func okButtonClicked() {
        let vc = ListViewController()

        if let title = mainView.titleTextField.text , title != "" {
            ListRepository().saveList(title: title, color: colorString)
        } else {
            ListRepository().saveList(title: "내 리스트 #\(tasks.count + 1)", color: colorString)
        }
        tasks = localRealm.objects(ListRealm.self)
        vc.task = tasks.last
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension AddListViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        mainView.colorButton.backgroundColor = color
        colorString = color.toHexString()
    }
}
