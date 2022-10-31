//
//  DetailViewController.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/14.
//

import UIKit

import Kingfisher
import PanModal

class DetailViewController: BaseViewController {
    
    let mainView = DetailView()
    
    var song: Song!
    
    var songList: [Song] = []
    
    var albumCover: String?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image:  UIImage(systemName: "chevron.left.circle.fill"), style: .plain, target: self, action: #selector(backButtonClicked))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func configure() {
        mainView.recommandTableView.delegate = self
        mainView.recommandTableView.dataSource = self
        mainView.recommandTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.reusableIdentifier)
        
        
        KaraokeAPIManager.shared.requestSearchSinger(text: song?.artist ?? "", brand: song?.brand ?? "tj", songTitle: song?.title ?? "") { [weak self] songList in
            self?.songList = songList
//            SpotifyAPIManager.shared.callToken { token in
//                for i in 0..<songList.count {
//                    SpotifyAPIManager.shared.requestSong(token: token, song: songList[i].title, singer: songList[i].artist) { albumCover in
//                        self.songList[i].albumImage = albumCover
                        DispatchQueue.main.async { [weak self] in
                            self?.mainView.recommandTableView.reloadData()
                        }
//                    }
                }
//            }
//            self.mainView.recommandTableView.reloadData()
//        }
        mainView.titleLabel.text = song.title
        mainView.artistLabel.text = song.artist
        mainView.numberLabel.text = song.number
        mainView.composerLabel.text = song.composer
        mainView.lyricistLabel.text = song.lyricist
        mainView.releaseLabel.text = song.release
        
        if song.brand == Brand.tj.rawValue {
            mainView.brandLabel.text = BrandText.TJ.rawValue
        } else {
            mainView.brandLabel.text = BrandText.KY.rawValue
        }
        
//        if song.albumImage == "" {
            mainView.albumImageView.image = UIImage(systemName: "music.note")
            mainView.albumImageView.tintColor = .mainColor
            mainView.albumImageView.layer.borderColor = UIColor.systemGray4.cgColor
            mainView.albumImageView.layer.borderWidth = 1
//        } else {
//            let url = URL(string: song.albumImage)
//            mainView.albumImageView.kf.setImage(with: url)
//            mainView.albumImageView.layer.borderWidth = 0
//        }
        
        
        mainView.addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
        
        mainView.youtubeButton.addTarget(self, action: #selector(youtubeButtonClicked), for: .touchUpInside)
//        mainView.lyricsButton.addTarget(self, action: #selector(lyricsButtonClicked), for: .touchUpInside)
    }
    
    @objc func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func addButtonClicked() {
        let vc = AddSongViewController()
        vc.song = song
        self.presentPanModal(vc)
    }
    
    @objc func youtubeButtonClicked() {
        let vc = WebViewController()
        let title = song?.title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let artist = song?.artist.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        vc.url = EndPoint.youtubeURL + "\(artist)+\(title)"
        present(vc, animated: true)
    }
    
//    @objc func lyricsButtonClicked() {
//        let vc = WebViewController()
//        let title = song?.title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
//        let artist = song?.artist.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
//        let lyrics = "가사".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
//        vc.url = EndPoint.lyricsNaverSearch + "\(artist)+\(title)+\(lyrics)"
//        present(vc, animated: true)
//    }
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
        
//        if songList[indexPath.row].albumImage == "" {
            cell.songView.albumImageView.image = UIImage(systemName: "music.note")
            cell.songView.albumImageView.tintColor = .mainColor
//        } else {
//            let url = URL(string: songList[indexPath.row].albumImage)
//            cell.songView.albumImageView.kf.setImage(with: url)
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SongMenuViewNavigtaionController()
        vc.nav.song = songList[indexPath.row]
        vc.nav.pvc = self.navigationController
        self.presentPanModal(vc)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}
