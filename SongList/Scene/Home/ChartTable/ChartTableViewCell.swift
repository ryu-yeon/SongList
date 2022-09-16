//
//  ChartTableViewCell.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/15.
//

import UIKit

import SnapKit

class ChartTableViewCell: BaseTableViewCell {
    
    var delegate: CVCellDelegate?
    
    let chartLabel: UILabel = {
        let view = UILabel()
        view.text = "인기 차트"
        view.font = .boldSystemFont(ofSize: 24)
        view.textColor = .black
        return view
    }()
    
    let chartCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 16
        let width = UIScreen.main.bounds.width - spacing * 2 - 16
        
        layout.itemSize = CGSize(width: width, height: 260)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .systemBackground
        return view
    }()
    
    let text = ["일간", "주간", "월간"]
    
    let range = ["daily", "weekly", "monthly"]
    
    var chartList: [Song] = []
    
    override func configureUI() {
        [chartLabel, chartCollectionView].forEach {
            self.addSubview($0)
        }
        chartCollectionView.delegate = self
        chartCollectionView.dataSource = self
        chartCollectionView.register(ChartCollectionViewCell.self, forCellWithReuseIdentifier: ChartCollectionViewCell.reusableIdentifier)
    }
    
    override func setConstraints() {
        
        chartLabel.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.leading.equalTo(28)
            make.height.equalTo(24)
        }
        
        chartCollectionView.snp.makeConstraints { make in
            make.top.equalTo(chartLabel.snp.bottom).offset(16)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.height.equalTo(260)
        }
    }
}

extension ChartTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChartCollectionViewCell.reusableIdentifier, for: indexPath) as? ChartCollectionViewCell else { return UICollectionViewCell() }
        
        cell.chartLabel.text = text[indexPath.item]
        cell.requestChart(range: range[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let delegate = delegate {
            let vc = ChartViewController()
            delegate.selectedCVCell(indexPath.item, vc: vc)
        }
    }
    

}
