//
//  AddSongVIewController.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/20.
//

import UIKit

import PanModal
import RealmSwift
import SwiftyJSON

class AddSongViewController: BaseViewController {
    
    private let mainView = AddSongView()
    
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
        
        mainView.createListButton.addTarget(self, action: #selector(createListButtonClicked), for: .touchUpInside)
    }
    
    override func configure() {
        
        tasks = localRealm.objects(ListRealm.self)
    }

    @objc func createListButtonClicked() {
        
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
        
        
        dismiss(animated: true)
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
        return .contentHeight(UIScreen.main.bounds.height / 2)
    }
    
    var longFormHeight: PanModalHeight {
        return .contentHeight(UIScreen.main.bounds.height / 2)
    }    
}
