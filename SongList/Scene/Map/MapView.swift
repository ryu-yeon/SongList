//
//  MapView.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/10.
//

import UIKit

import SnapKit

class MapView: BaseView {
    
    let segmentControl: UISegmentedControl = {
        let view = UISegmentedControl(items: ["노래방", "코인노래방"])
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .systemBackground
        [segmentControl].forEach {
            self.addSubview($0)
        }
    }
    
    override func setContraints() {
        segmentControl.snp.makeConstraints { make in
            make.top.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(40)
        }
    }
}
