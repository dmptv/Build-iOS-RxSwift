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
import RxDataSources

class FirstViewController: UIViewController, Stepper, FABMenuDelegate {
    
    private var flickrPhotosView: FlickrPhotosView!

    private(set) var viewModel: FirstVCViewModel
    private var currentPage = 1
    private var totalPages = 1
    
    var flickPhotosDataSourse: FlickPhotosDataSourse!

    var data = BehaviorRelay<[SectionOfCustomData]>(value: [
        SectionOfCustomData(title: "", items: [])
        ])
    private let disposeBag = DisposeBag()
    
    init(viewModel: FirstVCViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///FIXME: - Логику для infinity download - show/hide spinner , Infinite load,
    // if error downloding show alert
    // alert view when downloading
    // make currentPage totalPages - reactive
    
     //MARK: - View Life Circle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindRx()
        
        viewModel.geiPhotos(search: "NY", page: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let tabVC = parent as? AppTabBarController {
            tabVC.didTapTab = {_ in }
        }
        
        printMine(items: "resources: \(RxSwift.Resources.total)")
    }
    
    deinit {
        printMine(items: "deinited \(self.description)")
    }
    
    private func setupUI() {
        view.backgroundColor = .white

        setuFlickrPhotosView()
        setupFabMenu()
        setupRefreshControl()
    }
 
    private func setuFlickrPhotosView() {
        flickrPhotosView = FlickrPhotosView(frame: .zero)
        view.addSubview(flickrPhotosView)
        flickrPhotosView.snp.makeConstraints({ [weak self] (make) in
            guard let `self` = self else { return }
            make.edges.equalTo(self.view)
        })
        
        setupFlickPhotosDataSourse()
        setupflickrPhotosViewDelegate()
    }
    
    fileprivate func setupFlickPhotosDataSourse() {
        flickPhotosDataSourse = FlickPhotosDataSourse(collectionView: flickrPhotosView.collectionView)
        flickPhotosDataSourse.setPages(currentPage: currentPage, totalPages: totalPages)
    }
    
    fileprivate func setupflickrPhotosViewDelegate() {
        flickrPhotosView.collectionView.rx
            .setDelegate(flickrPhotosView)
            .disposed(by: disposeBag)
    }
    
    private func bindRx() {
        data.asDriver(onErrorJustReturn: [])
            .drive(flickrPhotosView.collectionView.rx.items(dataSource: flickPhotosDataSourse.dataSource!))
            .disposed(by: disposeBag)
        
        let photosDriver = viewModel.photo.asDriver(onErrorJustReturn: [])

        photosDriver
            .filter { $0.count > 0 }
            .drive(onNext: { [weak self] photos in
                guard let `self` = self else { return }
                self.data.accept([
                    SectionOfCustomData(title: "Section: 0", items: photos)
                    ])
            })
            .disposed(by: disposeBag)
        
        photosDriver
            .drive(onNext: { [weak self] photos in
                guard let `self` = self else { return }
                self.flickrPhotosView.itemsCount.accept(photos.count)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupFabMenu() {
        
    }
    
    private func setupRefreshControl() {
        
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














