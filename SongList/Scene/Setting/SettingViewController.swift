//
//  SettingViewController.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/10.
//

import UIKit

import AcknowList
import PanModal

class SettingViewController: BaseViewController {
    
    private let mainView = SettingView()
    
    let settingMenu: [String] = ["앱 버전", "앱 정보", "오픈소스 라이선스", "앱 메인 색상"]
    
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
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image:  UIImage(systemName: "chevron.left.circle.fill"), style: .plain, target: self, action: #selector(backButtonClicked))
        navigationItem.title = "설정"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Cafe24Ssurround", size: 18)!]
        
        mainView.settingTableView.delegate = self
        mainView.settingTableView.dataSource = self
        mainView.settingTableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.reusableIdentifier)
    }
    
    @objc func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.reusableIdentifier, for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
        
        cell.titleLabel.text = settingMenu[indexPath.row]
        
        if indexPath.row == 0 {
            cell.detailLabel.text = "1.0"
            cell.detailImageView.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1 :
            let vc = WebViewController()
            vc.url = EndPoint.infoURL
            present(vc, animated: true)
        case 2:
            let vc = AcknowListViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = SettingColorViewController()
            self.presentPanModal(vc)
        default: return
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
