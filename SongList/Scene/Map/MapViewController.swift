//
//  MapViewController.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/10.
//

import UIKit

class MapViewController: BaseViewController {
    
    private let mainView = MapView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configure() {
        
    }
    
}
