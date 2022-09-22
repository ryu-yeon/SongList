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
        view.font = .boldSystemFont(ofSize: 32)
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 24)
        return view
    }()
    
    let artistLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 18)
        view.textColor = .gray
        return view
    }()
    
    let likeButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        view.tintColor = .systemRed
        return view
    }()
        
    let detailButton: UIButton = {
        let view = UIButton()
        view.setTitle("곡 정보", for: .normal)
        view.backgroundColor = .green
        return view
    }()
    
    let addListButton: UIButton = {
        let view = UIButton()
        view.setTitle("리스트에 추가", for: .normal)
        view.backgroundColor = .green
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .systemBackground
        [likeButton, titleLabel, artistLabel, numberLabel, detailButton, addListButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setContraints() {
        
        
        numberLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(likeButton.snp.leading).offset(-8)
            make.height.equalTo(32)
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(numberLabel.snp.top)
            make.trailing.equalTo(self).inset(20)
            make.height.width.equalTo(numberLabel.snp.height)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(numberLabel.snp.bottom).offset(8)
            make.leading.equalTo(numberLabel.snp.leading)
            make.trailing.equalTo(likeButton.snp.trailing)
            make.height.equalTo(24)
        }
        
        artistLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(numberLabel.snp.leading)
            make.trailing.equalTo(likeButton.snp.trailing)
            make.height.equalTo(20)
        }
        
        detailButton.snp.makeConstraints { make in
            make.top.equalTo(artistLabel.snp.bottom).offset(20)
            make.leading.equalTo(numberLabel.snp.leading)
            make.trailing.equalTo(likeButton.snp.trailing)
            make.height.equalTo(48)
        }
        
        addListButton.snp.makeConstraints { make in
            make.top.equalTo(detailButton.snp.bottom).offset(16)
            make.leading.equalTo(numberLabel.snp.leading)
            make.trailing.equalTo(likeButton.snp.trailing)
            make.height.equalTo(48)
        }
    }
}
