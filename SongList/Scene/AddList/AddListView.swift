//
//  AddListView.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/19.
//

import UIKit

import SnapKit

class AddListView: BaseView {
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "리스트에 이름을 지정하세요."
        view.font = .boldSystemFont(ofSize: 28)
        return view
    }()
    
    let titleTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "내 리스트 #1"
        return view
    }()
    
    let cancelButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "xmark"), for: .normal)
        return view
    }()
    
    let okButton:UIButton = {
        let view = UIButton()
        view.setTitle("만들기", for: .normal)
        view.backgroundColor = .lightGray
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .systemBackground
        [titleLabel, titleTextField, cancelButton, okButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setContraints() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(40)
            make.centerX.equalTo(self)
            make.height.equalTo(80)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.65)
            make.height.equalTo(80)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-20)
            make.width.height.equalTo(40)
        }
        
        okButton.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
            make.centerX.equalTo(self)
            make.height.equalTo(40)
            make.width.equalTo(120)
        }
    }
}
    
