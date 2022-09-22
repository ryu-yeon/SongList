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
    
    var listTitle: String?
    
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
        
        ListRepository().saveList(title: listTitle ?? "내 리스트 #\(tasks.count + 1)", color: colorString ?? "#D3D3D3")
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        let nav = UINavigationController(rootViewController: HomeViewController())
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}

extension AddListViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        mainView.colorButton.backgroundColor = color
        colorString = color.toHexString()
    }
}
