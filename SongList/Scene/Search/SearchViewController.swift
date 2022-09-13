//
//  SearchViewController.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/13.
//

import UIKit

class SearchViewController: BaseViewController {
    
    private let mainView = SearchView()
    
    var searchText: String?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configure() {
        
        mainView.usertextField.text = searchText
        mainView.searchTableView.delegate = self
        mainView.searchTableView.dataSource = self
        mainView.searchTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.reusableIdentifier)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reusableIdentifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
