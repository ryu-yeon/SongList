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
    
    var delegate: TVCellDelegate?
    
    var chartList: [Song] = []
    
    var rank = 0
    
    let chartTableView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .none
        view.backgroundColor = .clear
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .clear
        contentView.addSubview(chartTableView)
        
        chartTableView.delegate = self
        chartTableView.dataSource = self
        chartTableView.register(RankTableViewCell.self, forCellReuseIdentifier: RankTableViewCell.reusableIdentifier)
        chartTableView.isScrollEnabled = false
    }

//    func requestAlbumCover(token: String) {
//        SpotifyAPIManager.shared.requestSong(token: token, song: self.chartList[0].title, singer: self.chartList[0].artist) { albumCover in
//            self.chartList[0].albumImage = albumCover
//            SpotifyAPIManager.shared.requestSong(token: token, song: self.chartList[1].title, singer: self.chartList[1].artist) { albumCover in
//                self.chartList[1].albumImage = albumCover
//                SpotifyAPIManager.shared.requestSong(token: token, song: self.chartList[2].title, singer: self.chartList[2].artist) { albumCover in
//                    self.chartList[2].albumImage = albumCover
//                    DispatchQueue.main.async {
//                        self.chartTableView.reloadData()
//                    }
//                }
//            }
//        }
//    }
    
    override func setConstraints() {
               
        chartTableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}

extension ChartCollectionViewCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chartList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RankTableViewCell.reusableIdentifier, for: indexPath) as? RankTableViewCell else { return UITableViewCell() }
        
        cell.rankLabel.text = "\(rank + indexPath.row + 1)"
        cell.titleLabel.text = chartList[indexPath.row].title
        cell.artistLabel.text = chartList[indexPath.row].artist
        cell.numberLabel.text = chartList[indexPath.row].number
        
        if chartList[indexPath.row].brand == Brand.tj.rawValue {
            cell.brandLabel.text = BrandText.TJ.rawValue
        } else {
            cell.brandLabel.text = BrandText.KY.rawValue
        }
        
//        if chartList[indexPath.row].albumImage == "" {
            cell.albumImageView.image = UIImage(systemName: "music.note")
            cell.albumImageView.tintColor = .systemMint
            cell.albumImageView.layer.borderColor = UIColor.systemGray4.cgColor
            cell.albumImageView.layer.borderWidth = 1
//        } else {
//            let url = URL(string: chartList[indexPath.row].albumImage)
//            cell.albumImageView.kf.setImage(with: url)
//            cell.albumImageView.layer.borderWidth = 0
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = delegate {
            let vc = SongMenuViewNavigtaionController()
            vc.nav.song = chartList[indexPath.row]
            delegate.selectedTVCell(indexPath.row, vc: vc)
        }
    }
}
