//
//  ChartViewController.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/16.
//

import UIKit

import Hero

class ChartViewController: BaseViewController {
    
    let mainView = ChartView()
    
    var range: String?
    
    var text: String?
    
    var chartList: [Song] = []
    
//    var albumCoverList = Array(repeating: "", count: 100)
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        KaraokeAPIManager.shared.requestChart(limit: 100, range: range ?? "") { charList in
//            self.chartList = charList
//
//            self.mainView.chartTableView.reloadData()
        //        }
        
        KaraokeAPIManager.shared.requestChart(limit: 100, range: range ?? "") { chartList in
            self.chartList = chartList
            SpotifyAPIManager.shared.callToken { token in
                for i in 0..<chartList.count {
                    SpotifyAPIManager.shared.requestSong(token: token, song: chartList[i].title, singer: chartList[i].artist) { albumCover in
                        self.chartList[i].alubmImage = albumCover
                        DispatchQueue.main.async {
                            self.mainView.chartTableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    override func configure() {
        
        mainView.chartTableView.delegate = self
        mainView.chartTableView.dataSource = self
        mainView.chartTableView.register(RankTableViewCell.self, forCellReuseIdentifier: RankTableViewCell.reusableIdentifier)
        
        mainView.rangeLabel.text = text ?? ""
    }
}

extension ChartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chartList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RankTableViewCell.reusableIdentifier, for: indexPath) as? RankTableViewCell else { return UITableViewCell() }
        
        cell.rankLabel.text = "\(indexPath.row + 1)"
        cell.titleLabel.text = chartList[indexPath.row].title
        cell.artistLabel.text = chartList[indexPath.row].artist
        cell.numberLabel.text = chartList[indexPath.row].number
        
        let url = URL(string: chartList[indexPath.row].alubmImage)
        cell.albumImageView.kf.setImage(with: url)
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.song = chartList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
