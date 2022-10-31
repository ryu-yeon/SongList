//
//  SearchViewController.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/13.
//

import UIKit

import Hero
import Kingfisher
import RealmSwift

class SearchViewController: BaseViewController {
    
    let mainView = SearchView()
    
    var searchList: [Song] = []
    
    var type = SearchType.song.rawValue
    
    var brand = Brand.tj.rawValue
    
//    var token = ""
    
    let searchTextRepository = SearchTextRepository()
    
    var tasks: Results<SearchTextRealm>!
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasks = searchTextRepository.fetchSort()
        mainView.searchContainer.isHeroEnabled = true
        mainView.searchContainer.heroID = "searchContainer"
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        self.navigationController?.navigationBar.tintColor = .mainColor
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
        
        mainView.searchTextTableView.delegate = self
        mainView.searchTextTableView.dataSource = self
        mainView.searchTextTableView.register(SearchTextTableViewCell.self, forCellReuseIdentifier: SearchTextTableViewCell.reusableIdentifier)
        
        mainView.xButton.addTarget(self, action: #selector(xButtonClicked), for: .touchUpInside)
        
        mainView.searchContainer.userTextField.addTarget(self, action: #selector(startingSearch), for: .editingDidBegin)
        
        mainView.searchContainer.userTextField.addTarget(self, action: #selector(searchTextEditing), for: .editingDidEnd)
        
        mainView.searchContainer.searchButton.addTarget(self, action: #selector(searchTextEditing), for: .touchUpInside)
        
        mainView.searchContainer.songSearchButton.addTarget(self, action: #selector(songSearchButtonClicked), for: .touchUpInside)
        mainView.searchContainer.artistSearchButton.addTarget(self, action: #selector(artistSearchButtonClicked), for: .touchUpInside)
        
        mainView.segmentControl.addTarget(self, action: #selector(segmentCotnrolValueChanged), for: .valueChanged)
        
        mainView.searchContainer.userTextField.becomeFirstResponder()
        buttonClicked()
        
//        SpotifyAPIManager.shared.callToken { token in
//            self.token = token
//        }
    }
    
    @objc func startingSearch() {
        mainView.searchTextTableView.isHidden = false
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
        searchTextEditing()
    }
    
    @objc func searchTextEditing() {
        
        guard var searchText = mainView.searchContainer.userTextField.text, searchText != "" else { return }
        
        
        for task in tasks {
            if task.text == searchText {
                self.searchTextRepository.removeText(task: task)
                break
            }
        }
        self.searchTextRepository.saveText(text: searchText)
        
        if searchList.count > 0 {
            self.mainView.searchTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }

        if type == "singer" && searchText == "아이유" {
            searchText = "IU"
        }
        
        KaraokeAPIManager.shared.requestSearch(text: searchText, type: type, brand: brand) { [weak self] songList in
            self?.searchList = songList
//            for i in 0..<self.searchList.count {
//                SpotifyAPIManager.shared.requestSong(token: self.token, song: self.searchList[i].title, singer: self.searchList[i].artist) { albumCover in
//                    self.searchList[i].albumImage = albumCover
                    DispatchQueue.main.async { [weak self] in
                        self?.mainView.searchTableView.reloadData()
                    }
//                }
//            }
        }
        view.endEditing(true)
        
        mainView.searchTextTableView.isHidden = true
        mainView.searchTextTableView.reloadData()
    }
    
    func buttonClicked() {
        if type == SearchType.song.rawValue {
            self.mainView.searchContainer.songSearchButton.setTitleColor(UIColor.mainColor, for: .normal)
            self.mainView.searchContainer.songSearchLine.backgroundColor = .mainColor
            self.mainView.searchContainer.artistSearchButton.setTitleColor(UIColor.systemGray4, for: .normal)
            self.mainView.searchContainer.artistSearchLine.backgroundColor = .systemGray4
            searchTextEditing()
        } else {
            self.mainView.searchContainer.songSearchButton.setTitleColor(UIColor.systemGray4, for: .normal)
            self.mainView.searchContainer.songSearchLine.backgroundColor = .systemGray4
            self.mainView.searchContainer.artistSearchButton.setTitleColor(UIColor.mainColor, for: .normal)
            self.mainView.searchContainer.artistSearchLine.backgroundColor = .mainColor
            searchTextEditing()
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
        if tableView == mainView.searchTableView {
            return searchList.count
        } else {
            return tasks.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == mainView.searchTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reusableIdentifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
            
            cell.songView.titleLabel.text = searchList[indexPath.row].title
            cell.songView.artistLabel.text = searchList[indexPath.row].artist
            cell.songView.numberLabel.text = searchList[indexPath.row].number
            
            if searchList[indexPath.row].brand == Brand.tj.rawValue {
                cell.songView.brandLabel.text = BrandText.TJ.rawValue
            } else {
                cell.songView.brandLabel.text = BrandText.KY.rawValue
            }
            
            //        if searchList[indexPath.row].albumImage == "" {
            cell.songView.albumImageView.image = UIImage(systemName: "music.note")
            cell.songView.albumImageView.tintColor = .mainColor
            cell.songView.albumImageView.layer.borderColor = UIColor.systemGray4.cgColor
            cell.songView.albumImageView.layer.borderWidth = 1
            //        } else {
            //            let url = URL(string: searchList[indexPath.row].albumImage)
            //            cell.songView.albumImageView.kf.setImage(with: url)
            //            cell.songView.albumImageView.layer.borderWidth = 0
            //        }
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTextTableViewCell.reusableIdentifier, for: indexPath) as? SearchTextTableViewCell else { return UITableViewCell() }
            cell.titleLabel.text = tasks[indexPath.row].text
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
        if tableView == mainView.searchTableView {
            let vc = SongMenuViewNavigtaionController()
            vc.nav.song = searchList[indexPath.row]
            vc.nav.pvc = self.navigationController
            self.presentPanModal(vc)
        } else {
            mainView.searchContainer.userTextField.text = tasks[indexPath.row].text
            searchTextEditing()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == mainView.searchTableView {
            return 70
        } else {
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if tableView == mainView.searchTextTableView {
            let removeButton = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
                self.searchTextRepository.removeText(task: self.tasks[indexPath.row])
                self.mainView.searchTextTableView.reloadData()
            }
            removeButton.image = UIImage(systemName: "trash.fill")
            removeButton.backgroundColor = .systemRed
            return UISwipeActionsConfiguration(actions: [removeButton])
        }
        return UISwipeActionsConfiguration()
    }
}

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextEditing()
        return true
    }
}
