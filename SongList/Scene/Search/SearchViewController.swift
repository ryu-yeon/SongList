//
//  SearchViewController.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/13.
//

import UIKit

import Hero

enum SearchType: String {
    case song
    case singer
}

enum BrandType: String {
    case tj
    case kumyoung
}

class SearchViewController: BaseViewController {
    
    private let mainView = SearchView()
    
    var searchList: [Song] = []
    
    var type: String?
    
    var brand = BrandType.tj.rawValue
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.searchContainer.isHeroEnabled = true
        mainView.searchContainer.heroID = "searchContainer"
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    override func configure() {
        
        mainView.searchTableView.delegate = self
        mainView.searchTableView.dataSource = self
        mainView.searchTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.reusableIdentifier)
        
        mainView.xButton.addTarget(self, action: #selector(xButtonClicked), for: .touchUpInside)
        
        mainView.searchContainer.userTextField.addTarget(self, action: #selector(searchTextEditing), for: .editingChanged)
        
        mainView.searchContainer.songSearchButton.addTarget(self, action: #selector(songSearchButtonClicked), for: .touchUpInside)
        mainView.searchContainer.artistSearchButton.addTarget(self, action: #selector(artistSearchButtonClicked), for: .touchUpInside)
        
        mainView.segmentControl.addTarget(self, action: #selector(segmentCotnrolValueChanged), for: .valueChanged)
        
        mainView.searchContainer.userTextField.becomeFirstResponder()
        buttonClicked()
    }
    
    @objc func songSearchButtonClicked() {
        type = SearchType.song.rawValue
        buttonClicked()
        searchTextEditing()
    }
    
    @objc func artistSearchButtonClicked() {
        type = SearchType.singer.rawValue
        buttonClicked()
        searchTextEditing()
    }
    
    @objc func segmentCotnrolValueChanged() {
        brand = mainView.segmentControl.selectedSegmentIndex == 0 ? BrandType.tj.rawValue : BrandType.kumyoung.rawValue
        searchTextEditing()
    }
    
    @objc func searchTextEditing() {
     
        KaraokeAPIManager.shared.requestSearch(text: mainView.searchContainer.userTextField.text ?? "", type: type ?? "song", brand: brand) { songList in
            self.searchList = songList
            self.mainView.searchTableView.reloadData()
        }
    }
    
    func buttonClicked() {
        if type == SearchType.song.rawValue {
            self.mainView.searchContainer.songSearchButton.backgroundColor = .red
            self.mainView.searchContainer.artistSearchButton.backgroundColor = .lightGray
        } else {
            self.mainView.searchContainer.songSearchButton.backgroundColor = .lightGray
            self.mainView.searchContainer.artistSearchButton.backgroundColor = .red
        }
    }
    
    @objc func xButtonClicked() {
        dismiss(animated: true)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reusableIdentifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        
        cell.songView.titleLabel.text = searchList[indexPath.row].title
        cell.songView.artistLabel.text = searchList[indexPath.row].artist
        cell.songView.numberLabel.text = searchList[indexPath.row].number
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.song = searchList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
