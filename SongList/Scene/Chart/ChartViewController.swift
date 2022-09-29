//
//  ChartViewController.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/16.
//

import UIKit

import Hero
import PanModal

class ChartViewController: BaseViewController {
    
    let mainView = ChartView()
    
    var range = Range.daily.rawValue
    
    var text: String?
    
    var brand = Brand.tj.rawValue
    
    var chartList: [Song] = []
    
    var token = ""
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SpotifyAPIManager.shared.callToken { token in
            self.token = token
            self.requestChart()
        }
    }
    
    override func configure() {
        
        mainView.chartTableView.delegate = self
        mainView.chartTableView.dataSource = self
        mainView.chartTableView.register(RankTableViewCell.self, forCellReuseIdentifier: RankTableViewCell.reusableIdentifier)
        
        mainView.segmentControl.addTarget(self, action: #selector(changValue), for: .valueChanged)
        
        mainView.dailyButton.addTarget(self, action: #selector(dailyButtonClicked), for: .touchUpInside)
        mainView.weeklyButton.addTarget(self, action: #selector(weeklyButtonClicked), for: .touchUpInside)
        mainView.monthlyButton.addTarget(self, action: #selector(monthlyButtonClicked), for: .touchUpInside)
        
        mainView.chartLabel.heroID = "chartLabel"
    }
    
    @objc func changValue() {
        if mainView.segmentControl.selectedSegmentIndex == 0 {
            chartList.removeAll()
            brand = Brand.tj.rawValue
            requestChart()
        } else {
            chartList.removeAll()
            brand = Brand.kumyoung.rawValue
            requestChart()
        }
    }
    
    @objc func dailyButtonClicked() {
        chartList.removeAll()
        range = Range.daily.rawValue
        mainView.dailyButton.backgroundColor = .systemMint
        mainView.weeklyButton.backgroundColor = .systemGray4
        mainView.monthlyButton.backgroundColor = .systemGray4
        requestChart()
    }
    
    @objc func weeklyButtonClicked() {
        chartList.removeAll()
        range = Range.weekly.rawValue
        mainView.dailyButton.backgroundColor = .systemGray4
        mainView.weeklyButton.backgroundColor = .systemMint
        mainView.monthlyButton.backgroundColor = .systemGray4
        requestChart()
    }
    
    @objc func monthlyButtonClicked() {
        chartList.removeAll()
        range = Range.monthly.rawValue
        mainView.dailyButton.backgroundColor = .systemGray4
        mainView.weeklyButton.backgroundColor = .systemGray4
        mainView.monthlyButton.backgroundColor = .systemMint
        requestChart()
    }
    
    func requestChart() {
        KaraokeAPIManager.shared.requestChart(limit: 100, range: range, brand: brand) { chartList in
            self.chartList = chartList
            for i in 0..<chartList.count {
                SpotifyAPIManager.shared.requestSong(token: self.token, song: chartList[i].title, singer: chartList[i].artist) { albumCover in
                    self.chartList[i].albumImage = albumCover
                    DispatchQueue.main.async {
                        self.mainView.chartTableView.reloadData()
                    }
                }
            }
        }
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
        
        if chartList[indexPath.row].brand == Brand.tj.rawValue {
            cell.brandLabel.text = BrandText.TJ.rawValue
        } else {
            cell.brandLabel.text = BrandText.KY.rawValue
        }
        
        let url = URL(string: chartList[indexPath.row].albumImage)
        cell.albumImageView.kf.setImage(with: url)
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SongMenuViewNavigtaionController()
        vc.nav.song = chartList[indexPath.row]
        vc.nav.pvc = self.navigationController
        self.presentPanModal(vc)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
