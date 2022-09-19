//
//  AddListViewController.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/19.
//

import UIKit

class AddListViewController: BaseViewController {
    
    private let mainView = AddListView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configure() {
        mainView.okButton.addTarget(self, action: #selector(okButtonClicked), for: .touchUpInside)
    }
    
    @objc func okButtonClicked() {
        let vc = ListViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
