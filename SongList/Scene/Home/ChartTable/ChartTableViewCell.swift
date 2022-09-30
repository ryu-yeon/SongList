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
    
    var chartList: [Song] = []
    
    var token = ""
    
    let chartLabel: UILabel = {
        let view = UILabel()
        view.text = Menu.second.rawValue
        view.font = UIFont(name: "Cafe24Ssurround", size: 24)
        view.textColor = .label
        return view
    }()
    
    let chartImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right.circle.fill")
        view.tintColor = .systemMint
        return view
    }()
    
    let chartButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .clear
        return view
    }()
    
    let tjButton: UIButton = {
        let view = UIButton()
        view.setTitle(BrandText.TJ.rawValue, for: .normal)
        view.titleLabel?.font = UIFont(name: "Cafe24Ssurround", size: 16)
        view.setTitleColor(UIColor.systemBackground, for: .normal)
        view.layer.cornerRadius = 8
        view.backgroundColor = .systemMint
        return view
    }()
    
    let kyButton: UIButton = {
        let view = UIButton()
        view.setTitle(BrandText.KY.rawValue, for: .normal)
        view.titleLabel?.font = UIFont(name: "Cafe24Ssurround", size: 16)
        view.setTitleColor(UIColor.label, for: .normal)
        view.layer.cornerRadius = 8
        view.backgroundColor = .systemGray4
        return view
    }()
    
    let chartCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 16
        let width = UIScreen.main.bounds.width - spacing * 2 - 28
        
        layout.itemSize = CGSize(width: width, height: 210)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .systemBackground
        view.showsHorizontalScrollIndicator = false
        view.decelerationRate = .fast
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .clear
        [chartLabel, chartImageView, chartButton, tjButton, kyButton, chartCollectionView].forEach {
            contentView.addSubview($0)
        }

        chartCollectionView.delegate = self
        chartCollectionView.dataSource = self
        chartCollectionView.register(ChartCollectionViewCell.self, forCellWithReuseIdentifier: ChartCollectionViewCell.reusableIdentifier)
        
        tjButton.addTarget(self, action: #selector(tjButtonClicked), for: .touchUpInside)
        kyButton.addTarget(self, action: #selector(kyButtonClicked), for: .touchUpInside)
        requestToken()
    }
    
    func requestChart(range: String, brand: String) {
        KaraokeAPIManager.shared.requestChart(limit: 15, range: range, brand: brand) { chartList in
            self.chartList = chartList
            DispatchQueue.main.async {
                self.chartCollectionView.reloadData()
            }
        }
    }
    
    func requestToken() {
        SpotifyAPIManager.shared.callToken { token in
            self.token = token
            self.requestChart(range: Range.daily.rawValue, brand: Brand.tj.rawValue)
        }
    }
    
    @objc func tjButtonClicked() {
        requestChart(range: Range.daily.rawValue, brand: Brand.tj.rawValue)
        chartCollectionView.reloadData()
        tjButton.backgroundColor = .systemMint
        tjButton.setTitleColor(UIColor.systemBackground, for: .normal)
        kyButton.backgroundColor = .systemGray4
        kyButton.setTitleColor(UIColor.label, for: .normal)
    }
    
    @objc func kyButtonClicked() {
        requestChart(range: Range.daily.rawValue, brand: Brand.kumyoung.rawValue)
        chartCollectionView.reloadData()
        tjButton.backgroundColor = .systemGray4
        tjButton.setTitleColor(UIColor.label, for: .normal)
        kyButton.backgroundColor = .systemMint
        kyButton.setTitleColor(UIColor.systemBackground, for: .normal)
    }
    
    override func setConstraints() {
        
        chartLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalTo(chartButton).inset(0)
        }
        
        chartImageView.snp.makeConstraints { make in
            make.leading.equalTo(chartLabel.snp.trailing).offset(8)
            make.centerY.equalTo(chartButton)
            make.width.height.equalTo(28)
        }
        
        chartButton.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.leading.equalTo(20)
            make.width.equalTo(140)
            make.height.equalTo(28)
        }
        
        tjButton.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.trailing.equalTo(kyButton.snp.leading).offset(-8)
            make.width.equalTo(40)
            make.height.equalTo(24)
        }
        
        kyButton.snp.makeConstraints { make in
            make.top.equalTo(tjButton.snp.top)
            make.trailing.equalTo(self).offset(-20)
            make.width.equalTo(tjButton.snp.width)
            make.height.equalTo(tjButton.snp.height)
        }
        
        chartCollectionView.snp.makeConstraints { make in
            make.top.equalTo(chartLabel.snp.bottom).offset(16)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.height.equalTo(210)
        }
    }
}

extension ChartTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChartCollectionViewCell.reusableIdentifier, for: indexPath) as? ChartCollectionViewCell else { return UICollectionViewCell() }
        
        if chartList.count == 15 {
            cell.chartList = [chartList[indexPath.item * 3], chartList[indexPath.item * 3 + 1], chartList[indexPath.item * 3 + 2]]
            cell.rank = indexPath.item * 3
            cell.requestAlbumCover(token: token)
        }
        cell.delegate = delegate as? TVCellDelegate
        
        return cell
    }
}

extension ChartTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let layout = self.chartCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
                
                let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
                
                let estimatedIndex = scrollView.contentOffset.x / cellWidthIncludingSpacing
                let index: Int
                if velocity.x > 0 {
                    index = Int(ceil(estimatedIndex))
                } else if velocity.x < 0 {
                    index = Int(floor(estimatedIndex))
                } else {
                    index = Int(round(estimatedIndex))
                }
                
                targetContentOffset.pointee = CGPoint(x: CGFloat(index) * cellWidthIncludingSpacing, y: 0)
    }
}
