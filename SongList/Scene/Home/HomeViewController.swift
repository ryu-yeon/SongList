//
//  HomeViewController.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/09.
//

import UIKit

class HomeViewController: BaseViewController {
    
    private let mainView = HomeView()
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configure() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.allowsSelection = false
        mainView.tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.reusableIdentifier)
        mainView.tableView.register(ChartTableViewCell.self, forCellReuseIdentifier: ChartTableViewCell.reusableIdentifier)
        mainView.tableView.register(BannerTableViewCell.self, forCellReuseIdentifier: BannerTableViewCell.reusableIdentifier)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0: guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reusableIdentifier) as? ListTableViewCell else { return UITableViewCell() }
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChartTableViewCell.reusableIdentifier) as? ChartTableViewCell  else { return UITableViewCell() }
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BannerTableViewCell.reusableIdentifier) as? BannerTableViewCell else { return UITableViewCell()}
            cell.bannerLabel.text = "주변 노래방 찾기"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0: return 24 + 16 + (UIScreen.main.bounds.width - 22 - 32) / 2.5 + 20
        case 1: return 20 + 24 + 210 + 16
        default: return 20 + 24 + 120 + 16
        }
    }
}
