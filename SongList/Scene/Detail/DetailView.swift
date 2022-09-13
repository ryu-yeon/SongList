//
//  DetailView.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/14.
//

import UIKit

import SnapKit

class DetailView: BaseView {
    
    let albumImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "star.fill")
        view.backgroundColor = .yellow
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "그라데이션"
        view.font = .boldSystemFont(ofSize: 24)
        return view
    }()
    
    let artistLabel: UILabel = {
        let view = UILabel()
        view.text = "10CM"
        view.font = .systemFont(ofSize: 20)
        return view
    }()
    
    let composerLabel: UILabel = {
        let view = UILabel()
        view.text = "권정열,윤철종"
        view.font = .systemFont(ofSize: 18)
        return view
    }()
    
    let lyricistLabel: UILabel = {
        let view = UILabel()
        view.text = "권정열,윤철종"
        view.font = .systemFont(ofSize: 18)
        return view
    }()
    
    let releaseLabel: UILabel = {
        let view = UILabel()
        view.text = "2022-01-01"
        view.font = .systemFont(ofSize: 18)
        return view
    }()
    
    let numberLabel: UILabel = {
        let view = UILabel()
        view.text = "123123"
        view.font = .boldSystemFont(ofSize: 28)
        return view
    }()
    
    let youtubeButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "play.square.fill"), for: .normal)
        view.tintColor = .systemRed
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let lyricsButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "text.alignleft"), for: .normal)
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let addButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "plus"), for: .normal)
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let likeButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        view.tintColor = .systemRed
        view.backgroundColor = .blue
        return view
    }()
    
    let recommandTableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .systemBackground
        [albumImageView, titleLabel, artistLabel, composerLabel, lyricistLabel, releaseLabel, numberLabel, youtubeButton, lyricsButton, addButton, likeButton, recommandTableView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setContraints() {
        
        albumImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(self).multipliedBy(0.4)
            make.height.equalTo(albumImageView.snp.width)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(albumImageView.snp.top)
            make.leading.equalTo(albumImageView.snp.trailing).offset(16)
            make.trailing.equalTo(self).offset(-20)
        }
        
        artistLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing)
        }
        
        composerLabel.snp.makeConstraints { make in
            make.top.equalTo(artistLabel.snp.bottom).offset(8)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing)
        }
        
        lyricistLabel.snp.makeConstraints { make in
            make.top.equalTo(composerLabel.snp.bottom).offset(8)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing)
        }
        
        releaseLabel.snp.makeConstraints { make in
            make.top.equalTo(lyricistLabel.snp.bottom).offset(8)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing)
        }
        
        numberLabel.snp.makeConstraints { make in
            make.top.equalTo(albumImageView.snp.bottom).offset(20)
            make.leading.equalTo(albumImageView.snp.leading)
            make.trailing.equalTo(albumImageView.snp.trailing)
            make.height.equalTo(40)
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(numberLabel.snp.top)
            make.leading.equalTo(titleLabel.snp.leading)
            make.width.height.equalTo(40)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(numberLabel.snp.top)
            make.leading.equalTo(likeButton.snp.trailing).offset(20)
            make.width.height.equalTo(40)
        }
        
        youtubeButton.snp.makeConstraints { make in
            make.top.equalTo(numberLabel.snp.bottom).offset(20)
            make.leading.equalTo(albumImageView.snp.leading)
            make.width.equalTo(self).multipliedBy(0.4)
            make.height.equalTo(50)
        }
        
        lyricsButton.snp.makeConstraints { make in
            make.top.equalTo(youtubeButton.snp.top)
            make.trailing.equalTo(titleLabel.snp.trailing)
            make.width.equalTo(self).multipliedBy(0.4)
            make.height.equalTo(50)
        }
        
        recommandTableView.snp.makeConstraints { make in
            make.top.equalTo(youtubeButton.snp.bottom).offset(20)
            make.leading.equalTo(albumImageView.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-20)
        }
    }
}
