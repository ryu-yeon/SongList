//
//  AddListView.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/19.
//

import UIKit

import SnapKit

class AddListView: BaseView {
        
    let colorButton: UIButton = {
        let view = UIButton()
        view.layer.borderColor = UIColor.label.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    let colorTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "리스트 커버 색상을 지정하세요."
        view.font = UIFont(name: "Cafe24Ssurround", size: 24)
        view.textColor = .label
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "리스트에 이름을 지정하세요."
        view.font = UIFont(name: "Cafe24Ssurround", size: 24)
        view.textColor = .label
        return view
    }()
    
    let titleTextField: UITextField = {
        let view = UITextField()
        view.borderStyle = .line
        return view
    }()
    
    let okButton:UIButton = {
        let view = UIButton()
        view.setTitle("만들기", for: .normal)
        view.setTitleColor(UIColor.label, for: .normal)
        view.titleLabel?.font  = UIFont(name: "Cafe24Ssurround", size: 20)
        view.backgroundColor = .systemMint
        view.layer.cornerRadius = 12
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .systemBackground
        [colorTitleLabel, colorButton, titleLabel, titleTextField, okButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        colorTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(40)
            make.leading.trailing.equalTo(self).inset(20)
        }
        
        colorButton.snp.makeConstraints { make in
            make.top.equalTo(colorTitleLabel.snp.bottom).offset(20)
            make.centerX.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.4)
            make.height.equalTo(colorButton.snp.width)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(colorButton.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self).inset(20)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self).inset(20)
            make.height.equalTo(48)
        }
        
        okButton.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
            make.centerX.equalTo(self)
            make.leading.trailing.equalTo(self).inset(20)
            make.height.equalTo(52)
        }
        
    }
}
    
