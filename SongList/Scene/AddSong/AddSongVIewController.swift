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
    
    let listRepository = ListRepository()
    
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
        tasks = listRepository.fetch()
        
        mainView.backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
    }
    
    @objc func backButtonClicked() {
        navigationController?.popViewController(animated: true)
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
        let url = URL(string: tasks[indexPath.item].image)
        cell.listImageView.kf.setImage(with: url)
        cell.countLabel.text = "\(tasks[indexPath.row].songs.count)곡"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let task = tasks[indexPath.row]
        
        let listTitle = task.title
        
        for i in task.songs {
            if song.number == i.number && song.brand == i.brand {
                view.makeToast("\(listTitle)에 이미 있습니다.", duration: 1.0, position: .bottom)
                return
            }
        }
        
        listRepository.addSong(task: task, song: song)
        
        guard let pvc = self.presentingViewController else { return }
        
        dismiss(animated: true) {
            pvc.view.makeToast("\(listTitle)에 추가되었습니다.", duration: 2.0, position: .bottom)
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
