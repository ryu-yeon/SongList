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
        view.image = UIImage(systemName: "music.note")
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    let brandLabel: UILabel = {
        let view = UILabel()
        view.font  = UIFont(name: "Cafe24Ssurround", size: 24)
        view.textColor = .label
        view.textAlignment = .right
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.font  = UIFont(name: "Cafe24Ssurround", size: 32)
        view.textColor = .label
        return view
    }()
    
    let artistLabel: UILabel = {
        let view = UILabel()
        view.font  = UIFont(name: "Cafe24Ssurround", size: 24)
        view.textColor = .systemGray2
        view.textAlignment = .left
        return view
    }()
    
    let numberLabel: UILabel = {
        let view = UILabel()
        view.font  = UIFont(name: "Cafe24Ssurround", size: 28)
        view.textColor = .label
        view.textAlignment = .right
        return view
    }()
    
    let composerLabel: UILabel = {
        let view = UILabel()
        view.font  = UIFont(name: "Cafe24Ssurround", size: 18)
        view.textColor = .label
        view.textAlignment = .left
        return view
    }()
    
    let lyricistLabel: UILabel = {
        let view = UILabel()
        view.font  = UIFont(name: "Cafe24Ssurround", size: 18)
        view.textColor = .label
        view.textAlignment = .left
        return view
    }()
    
    let releaseLabel: UILabel = {
        let view = UILabel()
        view.font  = UIFont(name: "Cafe24Ssurround", size: 18)
        view.textColor = .label
        view.textAlignment = .left
        return view
    }()
    
    let youtubeImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "youtube")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let youtubeButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 20
        return view
    }()
    
    let lyricsButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 20
        return view
    }()
    
    let lyricsImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "lyrics")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let addButton: UIButton = {
        let view = UIButton()
        view.setTitle("리스트에 추가", for: .normal)
        view.titleLabel?.font = UIFont(name: "Cafe24Ssurround", size: 20)
        view.setTitleColor(UIColor.systemBackground, for: .normal)
        view.backgroundColor = .systemMint
        view.layer.cornerRadius = 16
        return view
    }()
    
    let recommandLabel: UILabel = {
        let view = UILabel()
        view.text = "같은 가수 노래"
        view.font  = UIFont(name: "Cafe24Ssurround", size: 24)
        view.textColor = .label
        return view
    }()
    
    let recommandTableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .systemBackground
        [albumImageView, brandLabel, titleLabel, numberLabel, artistLabel, composerLabel, lyricistLabel, releaseLabel, youtubeImage, youtubeButton, lyricsImage, lyricsButton, addButton, recommandLabel, recommandTableView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        albumImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(8)
            make.centerX.equalTo(self)
            make.width.height.equalTo(160)
        }
        
        brandLabel.snp.makeConstraints { make in
            make.bottom.equalTo(releaseLabel.snp.bottom)
            make.trailing.equalTo(self).offset(-20)
            make.width.equalTo(52)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(albumImageView.snp.bottom).offset(16)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(self).offset(-20)
        }
        
        numberLabel.snp.makeConstraints { make in
            make.top.equalTo(composerLabel.snp.top)
            make.trailing.equalTo(titleLabel.snp.trailing)
            make.width.equalTo(120)
        }
        
        artistLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing)
        }
        
        composerLabel.snp.makeConstraints { make in
            make.top.equalTo(artistLabel.snp.bottom).offset(8)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(numberLabel.snp.leading).offset(-8)
            make.height.equalTo(20)
        }
        
        lyricistLabel.snp.makeConstraints { make in
            make.top.equalTo(composerLabel.snp.bottom).offset(4)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(numberLabel.snp.leading).offset(-8)
            make.height.equalTo(20)
        }
        
        releaseLabel.snp.makeConstraints { make in
            make.top.equalTo(lyricistLabel.snp.bottom).offset(4)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(numberLabel.snp.leading).offset(-8)
            make.height.equalTo(20)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(youtubeImage.snp.top)
            make.leading.equalTo(lyricsButton.snp.trailing).offset(20)
            make.trailing.equalTo(titleLabel.snp.trailing)
            make.height.equalTo(60)
        }
        
        youtubeImage.snp.makeConstraints { make in
            make.top.equalTo(brandLabel.snp.bottom).offset(8)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(80)
            make.height.equalTo(60)
        }
        
        youtubeButton.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(youtubeImage).inset(0)
        }
        
        lyricsImage.snp.makeConstraints { make in
            make.top.equalTo(youtubeImage.snp.top)
            make.leading.equalTo(youtubeButton.snp.trailing).offset(20)
            make.width.equalTo(80)
            make.height.equalTo(60)
        }
        
        lyricsButton.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(lyricsImage).inset(0)
        }
        
        recommandLabel.snp.makeConstraints { make in
            make.top.equalTo(youtubeImage.snp.bottom).offset(20)
            make.leading.equalTo(titleLabel.snp.leading)
        }
        
        recommandTableView.snp.makeConstraints { make in
            make.top.equalTo(recommandLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(self).inset(20)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-20)
        }
    }
}
