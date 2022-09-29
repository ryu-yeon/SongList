//
//  SongMenuViewNavigtaionController.swift
//  SongList
//
//  Created by 유연탁 on 2022/09/22.
//

import UIKit

import PanModal

class SongMenuViewNavigtaionController: UINavigationController, PanModalPresentable {
    
    let nav = SongMenuViewController()

    init() {
        super.init(nibName: nil, bundle: nil)
        viewControllers = [nav]
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func popViewController(animated: Bool) -> UIViewController? {
        let vc = super.popViewController(animated: animated)
        panModalSetNeedsLayoutUpdate()
        return vc
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        panModalSetNeedsLayoutUpdate()
    }

    var panScrollable: UIScrollView? {
        let vc = AddSongViewController()
        return vc.mainView.listTableView
    }

    var shortFormHeight: PanModalHeight {
        return .contentHeight(300)
    }
    
    var longFormHeight: PanModalHeight {
        return .contentHeight(300)
    }
}


class SongMenuViewController: BaseViewController {

    private let mainView = SongMenuView()
    
    var song: Song!
    
    var pvc: UINavigationController?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        navigationController?.isNavigationBarHidden = true
    }
    
    override func configure() {
        mainView.titleLabel.text = song.title
        mainView.artistLabel.text = song.artist
        mainView.numberLabel.text = song.number
        
        if song.brand == Brand.tj.rawValue {
            mainView.brandLabel.text = BrandText.TJ.rawValue
        } else {
            mainView.brandLabel.text = BrandText.KY.rawValue
        }
        
        mainView.detailButton.addTarget(self, action: #selector(detailButtonClicked), for: .touchUpInside)
        mainView.addListButton.addTarget(self, action: #selector(addListButtonClicked), for: .touchUpInside)
    }
    
    @objc func detailButtonClicked() {
        dismiss(animated: true) {
            let vc = DetailViewController()
            vc.song = self.song
            self.pvc?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func addListButtonClicked() {
        let vc = AddSongViewController()
        vc.song = self.song
        navigationController?.pushViewController(vc, animated: true)
    }
}
