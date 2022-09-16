//
//  ListViewController.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/16.
//

import UIKit

import Hero

class ListViewController: BaseViewController {
    
    let mainView = ListView()
    
    var number: Int?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    override func configure() {
        
        mainView.listTableView.delegate = self
        mainView.listTableView.dataSource = self
        
        mainView.listImage.isHeroEnabled = true
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}
