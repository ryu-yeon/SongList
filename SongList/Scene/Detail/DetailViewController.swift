//
//  DetailViewController.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/14.
//

import UIKit

class DetailViewController: BaseViewController {
    
    private let mainView = DetailView()
    
    var song: Song?
    
    var songList: [Song] = []
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configure() {
        mainView.recommandTableView.delegate = self
        mainView.recommandTableView.dataSource = self
        mainView.recommandTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.reusableIdentifier)
        
        let artist = song?.artist.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        KaraokeAPIManager.shared.requestSearch(text: artist, type: "singer", brand: song?.brand ?? "tj") { songList in
            self.songList = songList
            
            self.mainView.recommandTableView.reloadData()
        }
        
        mainView.titleLabel.text = song?.title
        mainView.artistLabel.text = song?.artist
        mainView.numberLabel.text = song?.number
        mainView.composerLabel.text = song?.composer
        mainView.lyricistLabel.text = song?.lyricist
        mainView.releaseLabel.text = song?.release
        mainView.brandLabel.text = song?.brand
        
        mainView.youtubeButton.addTarget(self, action: #selector(youtubeButtonClicked), for: .touchUpInside)
        mainView.lyricsButton.addTarget(self, action: #selector(lyricsButtonClicked), for: .touchUpInside)
    }
    
    @objc func youtubeButtonClicked() {
        let vc = WebViewController()
        let title = song?.title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let artist = song?.artist.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        vc.url = "https://m.youtube.com/results?sp=mAEA&search_query=\(title)+\(artist)"
        
        present(vc, animated: true)
    }
    
    @objc func lyricsButtonClicked() {

    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reusableIdentifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell()}
        
        cell.songView.titleLabel.text = songList[indexPath.row].title
        cell.songView.artistLabel.text = songList[indexPath.row].artist
        cell.songView.numberLabel.text = songList[indexPath.row].number
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}
