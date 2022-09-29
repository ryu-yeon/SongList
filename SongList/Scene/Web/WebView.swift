//
//  WebView.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/18.
//

import UIKit
import WebKit

class WebView: BaseView {

    let webView: WKWebView = {
        let view = WKWebView()
        
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .systemBackground
        [webView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        webView.snp.makeConstraints { make in
            make.leading.top.bottom.trailing.equalTo(self)
        }
    }
}
