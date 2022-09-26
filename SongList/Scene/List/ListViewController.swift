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
import Toast

class ListViewController: BaseViewController {
    
    let mainView = ListView()
    
    let localRealm = try! Realm()
    
    var task: ListRealm!
    
    var songList: DataList!
    
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
        
        guard let task = task else {
            mainView.listTitleLabel.text = songList?.title
            
            return
        }
        mainView.listTitleLabel.text = task.title
        mainView.listImage.backgroundColor = UIColor(hexFromString: task.color)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "삭제", style: .plain, target: self, action: #selector(removeButtonClicked))
    }
    
    @objc func removeButtonClicked() {
        let title = task.title
        let alert = UIAlertController(title: nil, message: "\(title)를(을) 삭제하시겠습니까?", preferredStyle: .alert)
        
        let remove = UIAlertAction(title: "삭제", style: .destructive) { _ in
            try! self.localRealm.write {
                self.localRealm.delete(self.task)
            }
            
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let sceneDelegate = windowScene?.delegate as? SceneDelegate
            let nav = UINavigationController(rootViewController: HomeViewController())
            sceneDelegate?.window?.rootViewController = nav
            sceneDelegate?.window?.makeKeyAndVisible()
    
            nav.view.makeToast("\(title)이(가) 삭제되었습니다.", duration: 2.0, position: .bottom)
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(cancel)
        alert.addAction(remove)
        present(alert, animated: true)
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let task = task {
            return task.songs.count
        } else {
            return songList.songs.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reusableIdentifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        
        guard let task = task else {
            cell.songView.titleLabel.text = songList.songs[indexPath.row].title
            cell.songView.artistLabel.text = songList.songs[indexPath.row].artist
            cell.songView.numberLabel.text = songList.songs[indexPath.row].number
            return cell
        }
        cell.songView.titleLabel.text = task.songs[indexPath.row].title
        cell.songView.artistLabel.text = task.songs[indexPath.row].artist
        cell.songView.numberLabel.text = task.songs[indexPath.row].number
        
        let url = URL(string: task.songs[indexPath.row].albumImage)
        cell.songView.albumImage.kf.setImage(with: url)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        
        guard let task = task else {
            vc.song = songList.songs[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
            return
        }
        
        let song = Song(brand: task.songs[indexPath.row].brand, albumImage: task.songs[indexPath.row].albumImage, number: task.songs[indexPath.row].number, title: task.songs[indexPath.row].title, artist: task.songs[indexPath.row].artist, composer: task.songs[indexPath.row].composer, lyricist: task.songs[indexPath.row].lyricist, release: task.songs[indexPath.row].release)
        vc.song = song
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        guard self.task != nil else { return nil}
        
        let removeButton = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            
            let title = self.task.songs[indexPath.row].title
            
            let alert = UIAlertController(title: nil, message: "\(title)를(을) 삭제하시겠습니까?", preferredStyle: .alert)
            
            let remove = UIAlertAction(title: "삭제", style: .destructive) { alert in
                
                
                try! self.localRealm.write {
                    self.localRealm.delete(self.task.songs[indexPath.row])
                }
                
                self.mainView.listTableView.reloadData()
                self.view.makeToast("\(title)이(가) 삭제되었습니다.", duration: 2.0, position: .bottom)
            }
            
            let cancel = UIAlertAction(title: "취소", style: .default)
            
            [cancel, remove].forEach {
                alert.addAction($0)
            }
            self.present(alert, animated: true)
        }
        
        removeButton.image = UIImage(systemName: "trash.fill")
        removeButton.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [removeButton])
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}
