//
//  SettingViewController.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/10.
//

import UIKit

import AcknowList

class SettingViewController: BaseViewController {
    
    private let mainView = SettingView()
    
    let settingMenu: [String] = ["문의하기", "리뷰작성", "앱 버전", "오픈소스 라이선스"]
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func configure() {
        
        navigationItem.title = "설정"
        
        mainView.settingTableView.delegate = self
        mainView.settingTableView.dataSource = self
        mainView.settingTableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.reusableIdentifier)
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.reusableIdentifier, for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
        
        cell.titleLabel.text = settingMenu[indexPath.row]
        
        if indexPath.row == 2 {
            cell.detailLabel.text = "1.0"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 3 {
            let vc = AcknowListViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
