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
        
        let secondVC = UINavigationController(rootViewController: ListBoxViewControlller())
        secondVC.tabBarItem.title = "ListBox"
        secondVC.tabBarItem.image = UIImage(systemName: "list.star")
        secondVC.tabBarItem.selectedImage = UIImage(systemName: "list.star")
        
        let thirdVC = UINavigationController(rootViewController: MapViewController())
        thirdVC.tabBarItem.title = "Map"
        thirdVC.tabBarItem.image = UIImage(systemName: "map")
        thirdVC.tabBarItem.selectedImage = UIImage(systemName: "map.fill")
        
        
        setViewControllers([firstVC, secondVC, thirdVC], animated: true)
    }
}
