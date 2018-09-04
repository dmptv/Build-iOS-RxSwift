//
//  FirstViewController.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 29.08.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit
import Material
import Moya
import PopupDialog
import SnapKit
import Kingfisher
import RxCocoa
import RxSwift

class FirstViewController: UIViewController, Stepper, FABMenuDelegate {

    private(set) var viewModel: FirstVCViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: FirstVCViewModel) {
        self.viewModel = viewModel
      
        super.init(nibName: nil, bundle: nil)

        
        setupFabMenu()
    }

    private func setupFabMenu() {
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        setupUI()
        
        viewModel.geiPhotos(search: "Party", page: 1)
        viewModel.photo.filter { $0.count > 0 }
            .subscribe(onNext: { arr in
            
            printMine(items: "----->>>>> ")
            printMine(items: arr)
                
                //FIXME: - make collection view RxCocoa
            
        }, onError: { err in
            printMine(items: err.localizedDescription)
            
        }).disposed(by: disposeBag)
        
    }
    
    private func setupUI() {
        setupCollectionView()
        setupRefreshControl()
    }
    
    private func setupCollectionView() {
        
    }
    
    private func setupRefreshControl() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let tabVC = parent as? AppTabBarController {
            tabVC.didTapTab = {_ in }
        }
        
    }
    
    // MARK: - Methods
    
    @objc
    private func refreshFeed() { }
    
    private func onUnauthorized() { }
    
    private func setupFABButton() { }
    
    private func setupFABMenuItems() { }
    
    private func setupFABMenuItem(title: String, onTap: @escaping (() -> Void)) -> FABMenuItem {
        
        return FABMenuItem()
    }
    
    private func openQuestionnaire(id: String, loadOnlyStatistics: Bool) { }
    
    // MARK: - FABMenuDelegate
    
    func fabMenuWillOpen(fabMenu: FABMenu) { }
    
    func fabMenuWillClose(fabMenu: FABMenu) { }
    
    func fabMenuDidClose(fabMenu: FABMenu) { }
    
}































