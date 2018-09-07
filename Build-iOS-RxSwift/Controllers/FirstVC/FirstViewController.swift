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
    
    var dataSource: RxCollectionViewSectionedAnimatedDataSource<SectionOfCustomData>?
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
    
    //FIXME: - Activity spinner as Viper, but in Rx way.(look to EmployeesView swift file), Infinite load,
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        setupUI()
        setupDataSource()
        bindRx()
        
        viewModel.geiPhotos(search: "NY", page: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let tabVC = parent as? AppTabBarController {
            tabVC.didTapTab = {_ in }
        }
        
    }
    
    private func bindRx() {
        data.asDriver()
            .drive(flickrPhotosView.collectionView.rx.items(dataSource: dataSource!)) 
            .disposed(by: disposeBag)
        
        viewModel.photo.asDriver()
            .filter { $0.count > 0 }
            .drive(onNext: { [weak self] photos in
                guard let `self` = self else { return }
                self.data.accept([
                    SectionOfCustomData(title: "Section: 0", items: photos)
                    ])
            })
            .disposed(by: disposeBag)
        
        viewModel.photo.asDriver()
            .drive(onNext: { [weak self] photos in
                guard let `self` = self else { return }
                self.flickrPhotosView.itemsCount.accept(photos.count)
            })
            .disposed(by: disposeBag)
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
    }
    
    private func setupFabMenu() {
        
    }
    
    private func setupRefreshControl() {
        
    }
    
    //MARK: - RxDataSources
    private func setupDataSource() {
        dataSource = RxCollectionViewSectionedAnimatedDataSource<SectionOfCustomData>(configureCell: {
            _, cv, indexPath, item in
            
            return self.photoItemCell(cv, cellForItemAt: indexPath, item: item)
            
        }, configureSupplementaryView: { item, cv, kind, indexPath in
            let header = cv.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PhotosCollectionViewHeader.defaultReuseIdentifier, for: indexPath) as! PhotosCollectionViewHeader
            header.titleLabel.text = "New York"
            return header
        }, canMoveItemAtIndexPath: { _, _ in true })
        
        flickrPhotosView.collectionView.rx
            .setDelegate(flickrPhotosView)
            .disposed(by: disposeBag)
    }
    
    private func photoItemCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, item: SectionOfCustomData.Item) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosColectionViewCell.defaultReuseIdentifier, for: indexPath) as! PhotosColectionViewCell
        
        cell.photoImageView.alpha = 0
        cell.photoImageView.kf.setImage(with: item.photoUrl) { image, error, cache, url in
            cell.photoImageView.image = image
            cell.photoImageView.contentMode = .scaleAspectFill
            UIView.animate(withDuration: 0.2, animations: {
                cell.photoImageView.alpha = 1.0
            })
        }
        return cell
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




































