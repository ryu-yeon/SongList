//
//  AddSongVIewController.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/20.
//

import UIKit

import PanModal
import RealmSwift
import Toast

class AddSongViewController: BaseViewController {
    
    let mainView = AddSongView()
    
    var song: Song!
    
    let localRealm = try! Realm()
    
    var tasks: Results<ListRealm>!
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.listTableView.delegate = self
        mainView.listTableView.dataSource = self
        mainView.listTableView.register(AddSongTalbeViewCell.self, forCellReuseIdentifier: AddSongTalbeViewCell.reusableIdentifier)
    }
    
    override func configure() {
        
        tasks = localRealm.objects(ListRealm.self)
    }
}

extension AddSongViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddSongTalbeViewCell.reusableIdentifier, for: indexPath) as? AddSongTalbeViewCell else { return UITableViewCell() }
        
        cell.titleLabel.text = tasks[indexPath.row].title
        cell.listImageView.backgroundColor = UIColor(hexFromString: tasks[indexPath.row].color)
        cell.countLabel.text = "\(tasks[indexPath.row].songs.count)곡"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        try! localRealm.write {
            tasks[indexPath.row].songs.append(SongRealm(brand: song.brand, number: song.number, title: song.title, artist: song.artist, composer: song.composer, lyricist: song.lyricist, release: song.release, albumImage: song.albumImage))
        }
        
        guard let pvc = self.presentingViewController else { return }
        
        dismiss(animated: true) {
            pvc.view.makeToast("\(self.tasks[indexPath.row].title)에 추가되었습니다.", duration: 2.0, position: .bottom)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension AddSongViewController: PanModalPresentable {
    
    var panScrollable: UIScrollView? {
        return mainView.listTableView
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(300)
    }
    
    var longFormHeight: PanModalHeight {
        return .contentHeight(300)
    }    
}
