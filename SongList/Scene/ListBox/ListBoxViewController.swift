//
//  ListBoxViewController.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/10.
//

import UIKit

class ListBoxViewControlller: BaseViewController {
    
    private let mainView = ListBoxView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configure() {
        mainView.listBoxCollectionView.delegate = self
        mainView.listBoxCollectionView.dataSource = self
        mainView.listBoxCollectionView.register(ListBoxCollectionViewCell.self, forCellWithReuseIdentifier: ListBoxCollectionViewCell.reusableIdentifier)
    }
}
extension ListBoxViewControlller: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListBoxCollectionViewCell.reusableIdentifier, for: indexPath) as? ListBoxCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
    
    
}
