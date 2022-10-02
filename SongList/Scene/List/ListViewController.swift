//
//  ListViewController.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/30.
//

import UIKit

import Hero
import Kingfisher
import RealmSwift

class ListViewController: BaseViewController {
    
    let mainView = ListView()
    
    var number = 0
    
    let localRealm = try! Realm()
    
    var task: ListRealm!
    
    var songList: DataList!
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isHeroEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        
        if let task = task {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.backgroundColor = UIColor(hexFromString: task.color)
            navigationController?.navigationBar.standardAppearance = navigationBarAppearance
            setNavigationBar()
        }
    }
    
    override func configure() {
        
        mainView.listTableView.delegate = self
        mainView.listTableView.dataSource = self
        mainView.listTableView.register(ListInfoTableViewCell.self, forCellReuseIdentifier: ListInfoTableViewCell.reusableIdentifier)
        mainView.listTableView.register(SearchTableViewCell .self, forCellReuseIdentifier: SearchTableViewCell.reusableIdentifier)
        
    }
    
    func setNavigationBar() {
        
        let editTitle = UIAction(title: "제목 수정", image: UIImage(systemName: "pencil")) { _ in
            
            let alert = UIAlertController(title: nil, message: "수정할 제목을 입력해주세요.", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            let ok = UIAlertAction(title: "확인", style: .destructive) { _ in
                
                if let newTitle = alert.textFields?[0].text , newTitle != "" {
                    try! self.localRealm.write {
                        self.task.title = newTitle
                    }
                    self.mainView.listTableView.reloadSections(IndexSet(0...0), with: .none)
                    self.view.makeToast("\(newTitle)로 변경되었습니다.", duration: 2.0, position: .bottom)
                }
            }
            alert.addAction(ok)
            alert.addAction(cancel)
            alert.addTextField { UITextField in
                UITextField.placeholder = "수정할 제목을 입력해주세요."
            }
            self.present(alert, animated: true)
        }
        
        let delete = UIAction(title: "삭제", image: UIImage(systemName: "trash.fill")) { _ in
            let title = self.task.title
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
            self.present(alert, animated: true)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "",                                                             image: UIImage(systemName: "ellipsis.circle"),                                                             primaryAction: nil,                                                             menu: UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [editTitle, delete]))
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        default :
            guard let task = task else { return songList.songs.count}
            return task.songs.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0 :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ListInfoTableViewCell.reusableIdentifier, for: indexPath) as? ListInfoTableViewCell else { return UITableViewCell() }
            
            cell.listImageView.heroID = "listImageView\(number)"
            guard let task = task else {
                let url = URL(string: songList.image)
                cell.listImageView.kf.setImage(with: url)
                cell.listImageView.backgroundColor = .systemGray3
                cell.listTitleLabel.text = songList.title
                cell.listCountLabel.text = "\(songList.songs.count)곡"

                return cell
            }
            cell.listImageView.backgroundColor = UIColor(hexFromString: task.color)
            cell.listTitleLabel.text = task.title
            cell.listCountLabel.text = "\(task.songs.count)곡"
            
            return cell
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reusableIdentifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
            
            guard let task = task else {
                
                if songList.songs[indexPath.row].albumImage == "" {
                    cell.songView.albumImageView.image = UIImage(systemName: "music.note")
                    cell.songView.albumImageView.tintColor = .systemMint
                } else {
                    let url = URL(string: songList.songs[indexPath.row].albumImage)
                    cell.songView.albumImageView.kf.setImage(with: url)
                }
                
                if songList.songs[indexPath.row].brand == Brand.tj.rawValue {
                    cell.songView.brandLabel.text = BrandText.TJ.rawValue
                } else {
                    cell.songView.brandLabel.text = BrandText.KY.rawValue
                }
                
                cell.songView.titleLabel.text = songList.songs[indexPath.row].title
                cell.songView.artistLabel.text = songList.songs[indexPath.row].artist
                cell.songView.numberLabel.text = songList.songs[indexPath.row].number
                
                return cell
            }
            
            cell.songView.titleLabel.text = task.songs[indexPath.row].title
            cell.songView.artistLabel.text = task.songs[indexPath.row].artist
            cell.songView.numberLabel.text = task.songs[indexPath.row].number
            
            if task.songs[indexPath.row].brand == Brand.tj.rawValue {
                cell.songView.brandLabel.text = BrandText.TJ.rawValue
            } else {
                cell.songView.brandLabel.text = BrandText.KY.rawValue
            }
            
            if task.songs[indexPath.row].albumImage == "" {
                cell.songView.albumImageView.image = UIImage(systemName: "music.note")
                cell.songView.albumImageView.tintColor = .systemMint
            } else {
                let url = URL(string: task.songs[indexPath.row].albumImage)
                cell.songView.albumImageView.kf.setImage(with: url)
            }

            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        switch indexPath.section {
        case 0: return UISwipeActionsConfiguration()
        default:
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
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if let task = task {
                let vc = DetailViewController()
                let song = Song(brand: task.songs[indexPath.row].brand, albumImage: task.songs[indexPath.row].albumImage, number: task.songs[indexPath.row].number, title: task.songs[indexPath.row].title, artist: task.songs[indexPath.row].artist, composer: task.songs[indexPath.row].composer, lyricist: task.songs[indexPath.row].lyricist, release: task.songs[indexPath.row].release)
                vc.song = song
                navigationController?.pushViewController(vc, animated: true)
            } else {
                let vc = SongMenuViewNavigtaionController()
                vc.nav.song = songList.songs[indexPath.row]
                vc.nav.pvc = self.navigationController
                self.presentPanModal(vc)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return 200
        default : return 70
        }
    }
}
