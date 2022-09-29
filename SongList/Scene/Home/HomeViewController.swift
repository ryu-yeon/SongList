//
//  HomeViewController.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/09.
//

import UIKit

import Hero
import PanModal

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
        mainView.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
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
        mainView.searchContainer.songSearchButton.addTarget(self, action: #selector(songSearchButtonClicked), for: .touchUpInside)
        mainView.searchContainer.artistSearchButton.addTarget(self, action: #selector(artistSearchButtonClicked), for: .touchUpInside)
        
        mainView.searchContainer.heroID = "searchContainer"
    }
    
    @objc func songSearchButtonClicked() {
        let vc =  SearchViewController()
        vc.type = SearchType.song.rawValue
        let nav = UINavigationController(rootViewController: vc)
        nav.isHeroEnabled = true
        nav.modalPresentationStyle = .fullScreen
        nav.heroModalAnimationType = .fade
        present(nav, animated: true)
    }
    
    @objc func artistSearchButtonClicked() {
        let vc =  SearchViewController()
        vc.type = SearchType.singer.rawValue
        let nav = UINavigationController(rootViewController: vc)
        nav.isHeroEnabled = true
        nav.modalPresentationStyle = .fullScreen
        nav.heroModalAnimationType = .fade
        present(nav, animated: true)
    }
    
    @objc func searchContainerButtonClicked() {
        let vc =  SearchViewController()
        let nav = UINavigationController(rootViewController: vc)
        vc.type = SearchType.song.rawValue
        nav.isHeroEnabled = true
        nav.modalPresentationStyle = .fullScreen
        nav.heroModalAnimationType = .fade
        present(nav, animated: true)
    }
    
    @objc func settingButtonClicked() {
        let vc = SettingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func chartButtonClicked() {
        let vc = ChartViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func mapButtonClicked() {
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
            
            cell.chartButton.addTarget(self, action: #selector(chartButtonClicked), for: .touchUpInside)
            cell.delegate = self
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BannerTableViewCell.reusableIdentifier) as? BannerTableViewCell else { return UITableViewCell()}
            
            cell.bannerLabel.text = Menu.thrid.rawValue
            cell.bannerButton.addTarget(self, action: #selector(mapButtonClicked), for: .touchUpInside)
            cell.bannerViewButton.addTarget(self, action: #selector(mapButtonClicked), for: .touchUpInside)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0: return 24 + 16 + (UIScreen.main.bounds.width - 22 - 32) / 2.5 + 20 + 8
        case 1: return 20 + 24 + 210 + 20
        default: return 20 + 24 + 120 + 16
        }
    }
}

extension HomeViewController: CVCellDelegate {
    func selectedCVCell(_ index: Int, vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: TVCellDelegate {
    func selectedTVCell(_ index: Int, vc: SongMenuViewNavigtaionController) {
        vc.nav.pvc = self.navigationController
        self.presentPanModal(vc)
    }
}
