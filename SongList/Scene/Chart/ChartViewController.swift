//
//  ChartViewController.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/16.
//

import UIKit

class ChartViewController: BaseViewController {
    private let mainView = ChartView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    override func configure() {
    }
}
