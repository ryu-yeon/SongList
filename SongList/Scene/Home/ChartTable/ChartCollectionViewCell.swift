//
//  ChartCollectionViewCell.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/15.
//

import UIKit

import Kingfisher
import SnapKit

protocol TVCellDelegate {
    func selectedTVCell(_ index: Int, vc: SongMenuViewNavigtaionController)
}

class ChartCollectionViewCell: BaseCollectionViewCell {
    
    var text = ""
    
    var delegate: TVCellDelegate?
    
    var chartList: [Song] = []
    
    let chartLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 20)
        return view
    }()
    
    let chartTableView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .none
        view.backgroundColor = .clear
        return view
    }()
    
    func requestChart(range: String) {
        KaraokeAPIManager.shared.requestChart(limit: 3, range: range) { chartList in
            self.chartList = chartList
            SpotifyAPIManager.shared.callToken { token in
                for i in 0..<chartList.count {
                    SpotifyAPIManager.shared.requestSong(token: token, song: chartList[i].title, singer: chartList[i].artist) { albumCover in
                        self.chartList[i].albumImage = albumCover
                        DispatchQueue.main.async {
                            self.chartTableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    override func configureUI() {
        self.backgroundColor = .white
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 20
        [chartLabel, chartTableView].forEach {
            self.addSubview($0)
        }
        
        chartTableView.delegate = self
        chartTableView.dataSource = self
        chartTableView.register(RankTableViewCell.self, forCellReuseIdentifier: RankTableViewCell.reusableIdentifier)
        chartTableView.isScrollEnabled = false
    }
    
    override func setConstraints() {
        
        chartLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(16)
            make.leading.equalTo(16)
            make.height.equalTo(24)
        }
        
        chartTableView.snp.makeConstraints { make in
            make.top.equalTo(chartLabel.snp.bottom).offset(16)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(180)
        }
    }
}


extension ChartCollectionViewCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chartList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RankTableViewCell.reusableIdentifier, for: indexPath) as? RankTableViewCell else { return UITableViewCell() }
        cell.rankLabel.text = "\(indexPath.row + 1)"
        cell.titleLabel.text = chartList[indexPath.row].title
        cell.artistLabel.text = chartList[indexPath.row].artist
        cell.numberLabel.text = chartList[indexPath.row].number
        
        let url = URL(string: chartList[indexPath.row].albumImage)
        cell.albumImageView.kf.setImage(with: url)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = delegate {
            let vc = SongMenuViewNavigtaionController()
            vc.nav.song = chartList[indexPath.row]
            delegate.selectedTVCell(indexPath.row, vc: vc)
        }
    }
}
