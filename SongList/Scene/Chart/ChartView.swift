//
//  ChartView.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/16.
//

import UIKit

import SnapKit

class ChartView: BaseView {
    
    let segmentControl: UISegmentedControl = {
        let view = UISegmentedControl(items: ["TJ", "금영"])
        return view
    }()
    
    let chartTableView: UITableView = {
        let view = UITableView()
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .systemBackground
        [segmentControl, chartTableView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setContraints() {
        
        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.centerX.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.7)
            make.height.equalTo(40)
        }
        chartTableView.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
