//
//  DetailView.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/14.
//

import UIKit

import SnapKit

class DetailView: BaseView {
    
    let backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let albumImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "music.note")
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    let brandLabel: UILabel = {
        let view = UILabel()
        view.text = "TJ"
        view.font = .boldSystemFont(ofSize: 24)
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "그라데이션"
        view.font = .boldSystemFont(ofSize: 36)
        return view
    }()
    
    let artistLabel: UILabel = {
        let view = UILabel()
        view.text = "10CM"
        view.font = .systemFont(ofSize: 24)
        return view
    }()
    
    let numberLabel: UILabel = {
        let view = UILabel()
        view.text = "123123"
        view.font = .boldSystemFont(ofSize: 28)
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
    
    let recommandLabel: UILabel = {
        let view = UILabel()
        view.text = "같은 가수 노래"
        view.font = .boldSystemFont(ofSize: 24)
        return view
    }()
    
    let recommandTableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .systemBackground
        [backgroundImageView, albumImageView, brandLabel, titleLabel, artistLabel, composerLabel, lyricistLabel, releaseLabel, numberLabel, youtubeButton, lyricsButton, addButton, likeButton, recommandLabel, recommandTableView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setContraints() {
        
        backgroundImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.15)
        }
        
        albumImageView.snp.makeConstraints { make in
            make.top.equalTo(backgroundImageView.snp.centerY)
            make.centerX.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.32)
            make.height.equalTo(albumImageView.snp.width)
        }
        
        brandLabel.snp.makeConstraints { make in
            make.top.equalTo(backgroundImageView.snp.bottom).offset(24)
            make.leading.equalTo(self).offset(20)
            make.height.equalTo(28)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(brandLabel.snp.bottom).offset(16)
            make.leading.equalTo(brandLabel.snp.leading)
            make.trailing.equalTo(self).offset(-20)
        }
        
        artistLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(numberLabel.snp.leading).offset(-8)
        }
        
        composerLabel.snp.makeConstraints { make in
            make.top.equalTo(artistLabel.snp.bottom).offset(8)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing)
        }
        
        lyricistLabel.snp.makeConstraints { make in
            make.top.equalTo(composerLabel.snp.bottom).offset(4)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing)
        }
        
        releaseLabel.snp.makeConstraints { make in
            make.top.equalTo(lyricistLabel.snp.bottom).offset(4)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing)
        }
        
        numberLabel.snp.makeConstraints { make in
            make.top.equalTo(artistLabel.snp.top)
            make.trailing.equalTo(titleLabel.snp.trailing)
            make.height.equalTo(36)
        }
        
        likeButton.snp.makeConstraints { make in
            make.bottom.equalTo(releaseLabel.snp.bottom)
            make.trailing.equalTo(addButton.snp.leading).offset(-16)
            make.width.height.equalTo(40)
        }
        
        addButton.snp.makeConstraints { make in
            make.bottom.equalTo(likeButton.snp.bottom)
            make.trailing.equalTo(titleLabel.snp.trailing)
            make.width.height.equalTo(40)
        }
        
        youtubeButton.snp.makeConstraints { make in
            make.top.equalTo(releaseLabel.snp.bottom).offset(20)
            make.leading.equalTo(titleLabel.snp.leading).offset(16)
            make.width.equalTo(self).multipliedBy(0.4)
            make.height.equalTo(50)
        }
        
        lyricsButton.snp.makeConstraints { make in
            make.top.equalTo(youtubeButton.snp.top)
            make.trailing.equalTo(titleLabel.snp.trailing).offset(-16)
            make.width.equalTo(self).multipliedBy(0.4)
            make.height.equalTo(50)
        }
        
        recommandLabel.snp.makeConstraints { make in
            make.top.equalTo(youtubeButton.snp.bottom).offset(20)
            make.leading.equalTo(titleLabel.snp.leading)
            make.height.equalTo(24)
        }
        
        recommandTableView.snp.makeConstraints { make in
            make.top.equalTo(recommandLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(self)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-20)
        }
    }
}
