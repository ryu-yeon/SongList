//
//  WebViewController.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/18.
//

import UIKit
import WebKit

class WebViewController: BaseViewController {
    
    private let mainView = WebView()
    
    var url = ""
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configure() {
        print(url)
        openWebpage(urlStr: url)
    }
    
    func openWebpage(urlStr: String) {
        guard let url = URL(string: urlStr) else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        mainView.webView.load(request)
    }
}

