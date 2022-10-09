//
//  ChartView.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/16.
//

import UIKit

import SnapKit

class ChartView: BaseView {
    
    let backButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "chevron.left.circle.fill"), for: .normal)
        view.tintColor = .mainColor
        view.contentVerticalAlignment = .fill
        view.contentHorizontalAlignment = .fill
        return view
    }()
    
    let chartLabel: UILabel = {
        let view = UILabel()
        view.text = Menu.second.rawValue
        view.font = UIFont(name: "Cafe24Ssurround", size: 38)
        view.textColor = .label
        return view
    }()
    
    let segmentControl: UISegmentedControl = {
        let view = UISegmentedControl(items: [BrandText.TJ.rawValue, BrandText.KY.rawValue])
        view.selectedSegmentIndex = 0
        view.selectedSegmentTintColor = .mainColor
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
        view.backgroundColor = .mainColor
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
        [backButton, chartLabel, segmentControl, dailyButton, weeklyButton, monthlyButton, chartTableView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        backButton.snp.makeConstraints { make in
            make.centerY.equalTo(chartLabel)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.width.height.equalTo(32)
        }
        
        chartLabel.snp.makeConstraints { make in
            make.centerY.equalTo(segmentControl.snp.bottom)
            make.leading.equalTo(backButton.snp.trailing).offset(8)
        }
        
        dailyButton.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom).offset(8)
            make.trailing.equalTo(weeklyButton.snp.leading).offset(-8)
            make.width.equalTo(40)
            make.height.equalTo(24)
        }
        
        weeklyButton.snp.makeConstraints { make in
            make.top.equalTo(dailyButton.snp.top)
            make.trailing.equalTo(monthlyButton.snp.leading).offset(-8)
            make.width.equalTo(dailyButton.snp.width)
            make.height.equalTo(dailyButton.snp.height)
        }
        
        monthlyButton.snp.makeConstraints { make in
            make.top.equalTo(dailyButton.snp.top)
            make.trailing.equalTo(segmentControl.snp.trailing)
            make.width.equalTo(dailyButton.snp.width)
            make.height.equalTo(dailyButton.snp.height)
        }
        
        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.width.equalTo(120)
            make.height.equalTo(36)
        }
        
        chartTableView.snp.makeConstraints { make in
            make.top.equalTo(dailyButton.snp.bottom).offset(8)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
