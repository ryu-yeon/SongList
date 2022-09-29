//
//  SongMenuView.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/22.
//

import UIKit

import SnapKit

class SongMenuView: BaseView {
    
    let numberLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Cafe24Ssurround", size: 32)
        view.textColor = .label
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Cafe24Ssurround", size: 28)
        view.textColor = .label
        return view
    }()
    
    let artistLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Cafe24Ssurround", size: 24)
        view.textColor = .systemGray2
        return view
    }()
    
    let brandLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Cafe24Ssurround", size: 24)
        view.textColor = .label
        return view
    }()
        
    let detailButton: UIButton = {
        let view = UIButton()
        view.setTitle("곡 정보", for: .normal)
        view.setTitleColor(UIColor.label, for: .normal)
        view.titleLabel?.font  = UIFont(name: "Cafe24Ssurround", size: 20)
        view.backgroundColor = .systemMint
        view.layer.cornerRadius = 12
        return view
    }()
    
    let addListButton: UIButton = {
        let view = UIButton()
        view.setTitle("리스트에 추가", for: .normal)
        view.setTitleColor(UIColor.label, for: .normal)
        view.titleLabel?.font  = UIFont(name: "Cafe24Ssurround", size: 20)
        view.backgroundColor = .systemGray4
        view.layer.cornerRadius = 12
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .systemBackground
        [brandLabel, titleLabel,artistLabel, numberLabel, detailButton, addListButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        numberLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(brandLabel.snp.leading).offset(-20)
        }
        
        brandLabel.snp.makeConstraints { make in
            make.top.equalTo(numberLabel.snp.top)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-20)
            make.width.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(numberLabel.snp.bottom).offset(8)
            make.leading.equalTo(numberLabel.snp.leading)
            make.trailing.equalTo(brandLabel.snp.trailing)
        }
        
        artistLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(numberLabel.snp.leading)
            make.trailing.equalTo(brandLabel.snp.trailing)
        }
        
        detailButton.snp.makeConstraints { make in
            make.top.equalTo(artistLabel.snp.bottom).offset(20)
            make.leading.equalTo(numberLabel.snp.leading)
            make.trailing.equalTo(brandLabel.snp.trailing)
            make.height.equalTo(52)
        }
        
        addListButton.snp.makeConstraints { make in
            make.top.equalTo(detailButton.snp.bottom).offset(16)
            make.leading.equalTo(numberLabel.snp.leading)
            make.trailing.equalTo(brandLabel.snp.trailing)
            make.height.equalTo(52)
        }
    }
}
