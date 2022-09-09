//
//  HomeTableViewCell.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/09.
//

import UIKit

import SnapKit

class HomeTableViewCell: BaseTableViewCell {
    
    let rankLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.text = "1"
        view.font = .boldSystemFont(ofSize: 28)
        return view
    }()
    
    let albumImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .red
        view.image = UIImage(systemName: "star.fill")
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "좋은날"
        view.font = .boldSystemFont(ofSize: 20)
        return view
    }()
    
    let artistLabel: UILabel = {
        let view = UILabel()
        view.text = "아이유(IU)"
        view.font = .systemFont(ofSize: 16)
        return view
    }()
    
    let numberLabel: UILabel = {
        let view = UILabel()
        view.text = "123123"
        view.font = .boldSystemFont(ofSize: 18)
        return view
    }()
    
    override func configureUI() {
        [rankLabel, albumImageView, titleLabel, artistLabel, numberLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        rankLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.leading.equalTo(16)
            make.height.equalTo(self).multipliedBy(0.8)
            make.width.equalTo(16)
        }
        
        albumImageView.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.leading.equalTo(rankLabel.snp.trailing).offset(8)
            make.height.equalTo(self).multipliedBy(0.8)
            make.width.equalTo(albumImageView.snp.height)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(albumImageView.snp.top)
            make.leading.equalTo(albumImageView.snp.trailing).offset(8)

        }

        artistLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(titleLabel.snp.leading)
            make.bottom.equalTo(albumImageView.snp.bottom)
        }

        numberLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.trailing.equalTo(-20)
            make.height.equalTo(self).multipliedBy(0.8)
        }
        
    }
}
