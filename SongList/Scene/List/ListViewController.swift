//
//  ListViewController.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/16.
//

import UIKit

import Hero
import RealmSwift
import Kingfisher

class ListViewController: BaseViewController {
    
    let mainView = ListView()
    
    let localRealm = try! Realm()
    
    var task: ListRealm!
    
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
        mainView.listTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.reusableIdentifier)
        
        mainView.listImage.isHeroEnabled = true
        mainView.listTitleLabel.text = task.title
        mainView.listImage.backgroundColor = UIColor(hexFromString: task.color)
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task.songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reusableIdentifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        
        cell.songView.titleLabel.text = task.songs[indexPath.row].title
        cell.songView.artistLabel.text = task.songs[indexPath.row].artist
        cell.songView.numberLabel.text = task.songs[indexPath.row].number
        
        let url = URL(string: task.songs[indexPath.row].albumImage)
        cell.songView.albumImage.kf.setImage(with: url)
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}
