//
//  SearchViewController.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/13.
//

import UIKit

import Hero
import Kingfisher

class SearchViewController: BaseViewController {
    
    private let mainView = SearchView()
    
    var searchList: [Song] = []
    
    var type = SearchType.song.rawValue
    
    var brand = Brand.tj.rawValue
    
    var token = ""
    
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
        
        mainView.searchContainer.userTextField.delegate = self
        mainView.searchTableView.delegate = self
        mainView.searchTableView.dataSource = self
        mainView.searchTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.reusableIdentifier)
        
        mainView.xButton.addTarget(self, action: #selector(xButtonClicked), for: .touchUpInside)
        
        mainView.searchContainer.userTextField.addTarget(self, action: #selector(searchTextEditing), for: .editingDidEnd)
        
        mainView.searchContainer.searchButton.addTarget(self, action: #selector(searchTextEditing), for: .touchUpInside)
        
        mainView.searchContainer.songSearchButton.addTarget(self, action: #selector(songSearchButtonClicked), for: .touchUpInside)
        mainView.searchContainer.artistSearchButton.addTarget(self, action: #selector(artistSearchButtonClicked), for: .touchUpInside)
        
        mainView.segmentControl.addTarget(self, action: #selector(segmentCotnrolValueChanged), for: .valueChanged)
        
        mainView.searchContainer.userTextField.becomeFirstResponder()
        buttonClicked()
        
        SpotifyAPIManager.shared.callToken { token in
            self.token = token
        }
    }
    
    @objc func songSearchButtonClicked() {
        searchList.removeAll()
        type = SearchType.song.rawValue
        buttonClicked()
    }
    
    @objc func artistSearchButtonClicked() {
        type = SearchType.singer.rawValue
        buttonClicked()
    }
    
    @objc func segmentCotnrolValueChanged() {
        brand = mainView.segmentControl.selectedSegmentIndex == 0 ? Brand.tj.rawValue : Brand.kumyoung.rawValue
        searchList.removeAll()
        searchTextEditing()
    }
    
    @objc func searchTextEditing() {
        
        KaraokeAPIManager.shared.requestSearch(text: mainView.searchContainer.userTextField.text ?? "", type: type, brand: brand) { songList in
            self.searchList = songList
            for i in 0..<self.searchList.count {
                SpotifyAPIManager.shared.requestSong(token: self.token, song: self.searchList[i].title, singer: self.searchList[i].artist) { albumCover in
                    self.searchList[i].albumImage = albumCover
                    DispatchQueue.main.async {
                        self.mainView.searchTableView.reloadData()
                    }
                }
            }
        }
        view.endEditing(true)
    }
    
    func buttonClicked() {
        if type == SearchType.song.rawValue {
            self.mainView.searchContainer.songSearchButton.setTitleColor(UIColor.systemMint, for: .normal)
            self.mainView.searchContainer.songSearchLine.backgroundColor = .systemMint
            self.mainView.searchContainer.artistSearchButton.setTitleColor(UIColor.systemGray4, for: .normal)
            self.mainView.searchContainer.artistSearchLine.backgroundColor = .systemGray4
        } else {
            self.mainView.searchContainer.songSearchButton.setTitleColor(UIColor.systemGray4, for: .normal)
            self.mainView.searchContainer.songSearchLine.backgroundColor = .systemGray4
            self.mainView.searchContainer.artistSearchButton.setTitleColor(UIColor.systemMint, for: .normal)
            self.mainView.searchContainer.artistSearchLine.backgroundColor = .systemMint
        }
    }
    
    @objc func xButtonClicked() {
        dismiss(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
        
        if searchList[indexPath.row].brand == Brand.tj.rawValue {
            cell.songView.brandLabel.text = BrandText.TJ.rawValue
        } else {
            cell.songView.brandLabel.text = BrandText.KY.rawValue
        }
        
        let url = URL(string: searchList[indexPath.row].albumImage)
        cell.songView.albumImageView.kf.setImage(with: url)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SongMenuViewNavigtaionController()
        vc.nav.song = searchList[indexPath.row]
        vc.nav.pvc = self.navigationController
        self.presentPanModal(vc)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextEditing()
        return true
    }
}
