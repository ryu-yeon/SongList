//
//  ChartViewController.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/16.
//

import UIKit

class ChartViewController: BaseViewController {
    
    private let mainView = ChartView()
    
    var range: String?
    
    var text: String?
    
    var chartList: [Song] = []
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ChartAPIManager.shared.requestChart(limit: 100, range: range ?? "") { charList in
            self.chartList = charList
            
            self.mainView.chartTableView.reloadData()
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
        cell.view.titleLabel.text = chartList[indexPath.row].title
        cell.view.artistLabel.text = chartList[indexPath.row].artist
        cell.view.numberLabel.text = chartList[indexPath.row].number
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
