//
//  AddSongVIewController.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/20.
//

import UIKit

import PanModal

class AddSongViewController: BaseViewController {
    
    private let mainView = AddSongView()
    
    override func loadView() {
        self.view = mainView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.listTableView.delegate = self
        mainView.listTableView.dataSource = self
        
        mainView.xButton.addTarget(self, action: #selector(xButtonClicked), for: .touchUpInside)
        mainView.createListButton.addTarget(self, action: #selector(createListButtonClicked), for: .touchUpInside)
    }
    
    override func configure() {
        
        
    }
    
    @objc func xButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func createListButtonClicked() {
        
    }
}

extension AddSongViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "아무노래"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        dismiss(animated: true)
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
