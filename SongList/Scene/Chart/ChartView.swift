//
//  ChartView.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/16.
//

import UIKit

import SnapKit

class ChartView: BaseView {
    
    let rangeLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 36)
        return view
    }()
    
    let segmentControl: UISegmentedControl = {
        let view = UISegmentedControl(items: ["TJ", "금영"])
        return view
    }()
    
    let chartTableView: UITableView = {
        let view = UITableView()
        view.separatorInset = .zero
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .systemBackground
        [rangeLabel, segmentControl, chartTableView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setContraints() {
        
        rangeLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(20)
            make.width.equalTo(72)
            make.height.equalTo(40)
        }
        
        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
        
        chartTableView.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
