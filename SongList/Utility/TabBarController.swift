//
//  TabBarController.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/10.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    func configure() {
        let firstVC = UINavigationController(rootViewController: HomeViewController())
        firstVC.tabBarItem.title = "Home"
        firstVC.tabBarItem.image = UIImage(systemName: "house")
        firstVC.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        
        
        
        setViewControllers([firstVC], animated: true)
    }
}
