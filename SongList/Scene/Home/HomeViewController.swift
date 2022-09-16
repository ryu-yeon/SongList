//
//  HomeViewController.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/09.
//

import UIKit

import Hero

class HomeViewController: BaseViewController {
    
    private let mainView = HomeView()
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        navigationController?.isHeroEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func configure() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.allowsSelection = false
        mainView.tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.reusableIdentifier)
        mainView.tableView.register(ChartTableViewCell.self, forCellReuseIdentifier: ChartTableViewCell.reusableIdentifier)
        mainView.tableView.register(BannerTableViewCell.self, forCellReuseIdentifier: BannerTableViewCell.reusableIdentifier)
        
        mainView.settingButton.addTarget(self, action: #selector(settingButtonClicked), for: .touchUpInside)
        mainView.searchContainerButton.addTarget(self, action: #selector(searchContainerButtonClicked), for: .touchUpInside)
        
        mainView.searchContainer.heroID = "searchContainer"
    }
    
    @objc func searchContainerButtonClicked() {
        print(#function)
        let vc = SearchViewController()
        vc.isHeroEnabled = true
        vc.modalPresentationStyle = .fullScreen
        vc.heroModalAnimationType = .fade
        present(vc, animated: true)
    }
    
    @objc func settingButtonClicked() {
        print(#function)
        let vc = SettingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func mapButtonClicked() {
        print(#function)
        let vc = MapViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0: guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reusableIdentifier) as? ListTableViewCell else { return UITableViewCell() }
            
            cell.delegate = self
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChartTableViewCell.reusableIdentifier) as? ChartTableViewCell  else { return UITableViewCell() }
            
            cell.delegate = self
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BannerTableViewCell.reusableIdentifier) as? BannerTableViewCell else { return UITableViewCell()}
            cell.bannerLabel.text = "주변 노래방 찾기"
            cell.bannerButton.addTarget(self, action: #selector(mapButtonClicked), for: .touchUpInside)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0: return 24 + 16 + (UIScreen.main.bounds.width - 22 - 32) / 2.5 + 20
        case 1: return 20 + 24 + 260 + 16
        default: return 20 + 24 + 120 + 16
        }
    }
}

extension HomeViewController: CVCellDelegate {
    func selectedCVCell(_ index: Int, vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }

}
