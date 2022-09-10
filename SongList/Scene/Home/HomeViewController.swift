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
        
        navigationItem.title = "Home"
        mainView.chartTableView.delegate = self
        mainView.chartTableView.dataSource = self
        mainView.chartTableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.reusableIdentifier)
        mainView.themeCollectionView.delegate = self
        mainView.themeCollectionView.dataSource = self
        mainView.themeCollectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.reusableIdentifier)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.reusableIdentifier, for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        
        cell.rankLabel.text = "\(indexPath.row + 1)"
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.reusableIdentifier, for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }


}
