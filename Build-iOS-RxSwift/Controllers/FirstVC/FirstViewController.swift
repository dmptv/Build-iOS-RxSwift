//
//  FirstViewController.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 29.08.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit
import Material
import PopupDialog
import SnapKit
import Kingfisher
import RxCocoa
import RxSwift
import RxDataSources

class FirstViewController: UIViewController, Stepper, FABMenuDelegate, ViewModelBased {
    typealias ViewModelType = FirstVCViewModel
    var viewModel: FirstVCViewModel!
    
    private var flickrPhotosView: FlickrPhotosView!
//    private var currentPage: Int = 1
    var currentPage = BehaviorRelay<Int>(value: 1)
    
    var flickPhotosDataSourse: FlickPhotosDataSourse!
    var photosArray = [FlickrPhoto]()

    var data = BehaviorRelay<[SectionOfCustomData]>(value: [
        SectionOfCustomData(title: "", items: [])
        ])
    private let disposeBag = DisposeBag()
    
    ///FIXME: - if error downloding show alert, alert view when downloading
    
     //MARK: - View Life Circle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindRx()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let tabVC = parent as? AppTabBarController {
            tabVC.didTapTab = {_ in }
        }
        
        printMine(items: "resources: \(RxSwift.Resources.total)")
    }
    
    deinit {
        printMine(items: "resources: \(RxSwift.Resources.decrementTotal())")
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
                self.isNotFirstAttempting = true
                self.photosArray.append(contentsOf: photos)
                self.data.accept([
                    SectionOfCustomData(title: "Section: 0", items: self.photosArray)
                    ])
                
                self.flickrPhotosView.itemsCount.accept(self.photosArray.count)
            })
            .disposed(by: disposeBag)
        
        viewModel.pages.asDriver(onErrorJustReturn: 1)
            .drive(onNext: { [weak self] pages in
                guard let `self` = self else { return }
                self.flickPhotosDataSourse.pages.accept(pages)
            })
            .disposed(by: disposeBag)
        
        flickPhotosDataSourse.isFetchPhotos.asDriver()
            .filter { $0 == true }
            .drive(onNext: { [weak self] isFetching in
                guard let `self` = self else { return }
     
                if self.isNotFirstAttempting {
                    let tempCurrentPage = self.currentPage.value + 1
                    self.currentPage.accept(tempCurrentPage)
                }
                
                self.viewModel.geiPhotos(search: "NY", page: self.currentPage.value)
            })
            .disposed(by: disposeBag)
        
        currentPage.asDriver()
            .drive(onNext: { [weak self] pages in
            guard let `self` = self else { return }
            self.flickPhotosDataSourse.currentPage.accept(pages)
        })
            .disposed(by: disposeBag)
        
    }
    
    private var isNotFirstAttempting = false

    
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














