//
//  ChartView.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/16.
//

import UIKit

import SnapKit

class ChartView: BaseView {
    
    let chartLabel: UILabel = {
        let view = UILabel()
        view.text = Menu.second.rawValue
        view.font = UIFont(name: "Cafe24Ssurround", size: 32)
        view.textColor = .label
        return view
    }()
    
    let segmentControl: UISegmentedControl = {
        let view = UISegmentedControl(items: [BrandText.TJ.rawValue, BrandText.KY.rawValue])
        view.selectedSegmentIndex = 0
        view.selectedSegmentTintColor = .systemMint
        view.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Cafe24Ssurround", size: 20)!, NSAttributedString.Key.foregroundColor : UIColor.label], for: .normal)
        view.tintColor = .systemGray4
        return view
    }()
    
    let dailyButton: UIButton = {
        let view = UIButton()
        view.setTitle(RangeText.daily.rawValue, for: .normal)
        view.titleLabel?.font = UIFont(name: "Cafe24Ssurround", size: 16)
        view.setTitleColor(UIColor.label, for: .normal)
        view.layer.cornerRadius = 8
        view.backgroundColor = .systemMint
        return view
    }()
    
    let weeklyButton: UIButton = {
        let view = UIButton()
        view.setTitle(RangeText.weekly.rawValue, for: .normal)
        view.titleLabel?.font = UIFont(name: "Cafe24Ssurround", size: 16)
        view.setTitleColor(UIColor.label, for: .normal)
        view.layer.cornerRadius = 8
        view.backgroundColor = .systemGray4
        return view
    }()
    
    let monthlyButton: UIButton = {
        let view = UIButton()
        view.setTitle(RangeText.monthly.rawValue, for: .normal)
        view.titleLabel?.font = UIFont(name: "Cafe24Ssurround", size: 16)
        view.setTitleColor(UIColor.label, for: .normal)
        view.layer.cornerRadius = 8
        view.backgroundColor = .systemGray4
        return view
    }()
    
    let chartTableView: UITableView = {
        let view = UITableView()
        view.separatorInset = .zero
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .systemBackground
        [chartLabel, segmentControl, dailyButton, weeklyButton, monthlyButton, chartTableView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        chartLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
        }
        
        dailyButton.snp.makeConstraints { make in
            make.top.equalTo(chartLabel.snp.bottom).offset(8)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(40)
            make.height.equalTo(24)
        }
        
        weeklyButton.snp.makeConstraints { make in
            make.top.equalTo(dailyButton.snp.top)
            make.leading.equalTo(dailyButton.snp.trailing).offset(8)
            make.width.equalTo(dailyButton.snp.width)
            make.height.equalTo(dailyButton.snp.height)
        }
        
        monthlyButton.snp.makeConstraints { make in
            make.top.equalTo(dailyButton.snp.top)
            make.leading.equalTo(weeklyButton.snp.trailing).offset(8)
            make.width.equalTo(dailyButton.snp.width)
            make.height.equalTo(dailyButton.snp.height)
        }
        
        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
        
        chartTableView.snp.makeConstraints { make in
            make.top.equalTo(dailyButton.snp.bottom).offset(8)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
