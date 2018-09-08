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
import Moya
import NVActivityIndicatorView

class FirstViewController: UIViewController, Stepper, FABMenuDelegate, ViewModelBased {
    typealias ViewModelType = FirstVCViewModel
    var viewModel: FirstVCViewModel!
    
    var spinner = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 120, height: 80), type: .ballPulseSync, color: App.Color.midGreen, padding: 0)
    private var flickrPhotosView: FlickrPhotosView!
    
    var flickPhotosDataSourse: FlickPhotosDataSourse!
    var data = BehaviorRelay<[SectionOfCustomData]>(value: [
        SectionOfCustomData(title: "", items: [])
        ])
    var photosArray = BehaviorRelay<[FlickrPhoto]>(value: [])
        // [FlickrPhoto]()
    var currentPage = BehaviorRelay<Int>(value: 1)
    private let disposeBag = DisposeBag()
    private var isNotFirstAttempting = false
    
    /// FIXME: - refreshFeed
    // FabMenu, shoose form, send form with multipart data (find server with callbak for testing)
    // show detail view controller
    // https://github.com/hyperoslo/Lightbox / LightboxController - make Header with slide show - refactor
    // look up - ProfileViewController
    
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

        setupWaitingView()
        setuFlickrPhotosView()
        setupFabMenu()
        setupRefreshControl()
    }
    
    private func setupWaitingView() {
        view.addSubview(spinner)
        spinner.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        view.bringSubview(toFront: spinner)
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
        
        photosArray.asDriver(onErrorJustReturn: [])
            .filter { $0.count == 0 }
            .drive(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                self.startLoading()
            })
            .disposed(by: disposeBag)
        
        let photosDriver = viewModel.photo.asDriver(onErrorJustReturn: [])
            .filter { $0.count > 0 }
            .asDriver()
        
        photosDriver
            .drive(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                self.stopLoading()
            })
            .disposed(by: disposeBag)
        
        photosDriver
            .drive(onNext: { [weak self] photos in
                guard let `self` = self else { return }
                self.isNotFirstAttempting = true
                var tempArr: [FlickrPhoto] = self.photosArray.value
                tempArr.append(contentsOf: photos)
                self.photosArray.accept(tempArr)
            })
            .disposed(by: disposeBag)

        photosDriver
            .drive(onNext: { [weak self] photos in
                guard let `self` = self else { return }
                self.data.accept([
                    SectionOfCustomData(title: "Section: 0", items: self.photosArray.value)
                    ])
                
                self.flickrPhotosView.itemsCount.accept(self.photosArray.value.count)
            })
            .disposed(by: disposeBag)
        
        photosDriver
            .drive(onNext: { [weak self] photos in
                guard let `self` = self else { return }
                self.flickrPhotosView.itemsCount.accept(self.photosArray.value.count)
            })
            .disposed(by: disposeBag)
        
        viewModel.pages.asDriver(onErrorJustReturn: 1)
            .distinctUntilChanged()
            .drive(onNext: { [weak self] pages in
                guard let `self` = self else { return }
                self.flickPhotosDataSourse.pages.accept(pages)
            })
            .disposed(by: disposeBag)
        
        // bind fetching
        flickPhotosDataSourse.isFetchPhotos.asDriver()
            .filter { $0 == true }
            .drive(onNext: { [weak self] isFetching in
                guard let `self` = self else { return }
     
                if self.isNotFirstAttempting {
                    let tempCurrentPage = self.currentPage.value + 1
                    self.currentPage.accept(tempCurrentPage)
                }
                
                self.viewModel.geiPhotos(search: "San-Francisco", page: self.currentPage.value)
            })
            .disposed(by: disposeBag)
        
        currentPage.asDriver()
            .drive(onNext: { [weak self] pages in
                guard let `self` = self else { return }
                self.flickPhotosDataSourse.currentPage.accept(pages)
            })
            .disposed(by: disposeBag)
        
        // bind for error
        viewModel.onError
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                guard let `self` = self else { return }
                
                if let moyaError = error as? MoyaError {
                    self.showErrorAlert(moyaError.localizedDescription)
                }
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
    
    public func startLoading() {
        spinner.isHidden = false
        spinner.startAnimating()
    }
    
    public func stopLoading() {
        spinner.isHidden = true
        spinner.stopAnimating()
    }
  
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














