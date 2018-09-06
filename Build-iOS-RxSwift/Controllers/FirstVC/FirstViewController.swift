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

    private(set) var viewModel: FirstVCViewModel
    var currentPage = 1
    var totalPages = 1
    
    private let disposeBag = DisposeBag()
    
    var collectionView: UICollectionView!
    
    var data = BehaviorRelay<[SectionOfCustomData]>(value: [
        SectionOfCustomData(title: "", items: [])
        ])
    
    var dataSource: RxCollectionViewSectionedAnimatedDataSource<SectionOfCustomData>?
    
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
    
    //FIXME: - Activity spinner as Viper, but in Rx way.(look to EmployeesView swift file)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        viewModel.geiPhotos(search: "NY", page: 1)
   
        setupUI()
        
        data.asDriver()
            .drive(collectionView.rx.items(dataSource: dataSource!))
            .disposed(by: disposeBag)
        
        viewModel.photo.asObservable()
            .filter { $0.count > 0 }
            .subscribe({[weak self] event in
                self?.data.accept([
                    SectionOfCustomData(title: "Section: 0", items: event.element ?? [])
                    ])
            })
            .disposed(by: disposeBag)
    }
    
    private func setupUI() {
        setupCollectionView()
        setupRefreshControl()
        
        setupDataSource()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        
        collectionView.register(PhotosColectionViewCell.self, forCellWithReuseIdentifier: PhotosColectionViewCell.defaultReuseIdentifier)
        collectionView.register(PhotosCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: PhotosCollectionViewHeader.defaultReuseIdentifier)
    }
    
    private func setupDataSource() {
        dataSource = RxCollectionViewSectionedAnimatedDataSource<SectionOfCustomData>(configureCell: {
            _, cv, indexPath, item in
            
            return self.photoItemCell(cv, cellForItemAt: indexPath, item: item)
            
        }, configureSupplementaryView: { item, cv, kind, indexPath in
            let header = cv.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PhotosCollectionViewHeader.defaultReuseIdentifier, for: indexPath) as! PhotosCollectionViewHeader
            // invisible now - need size
            header.titleLabel.text = "Section \(indexPath.section)"
            return header
        },
           canMoveItemAtIndexPath: { _, _ in true })
        
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
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

// MARK:- UICollectionViewDelegateFlowLayout
extension FirstViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var itemSize: CGSize
        let length = (UIScreen.main.bounds.width) / 3 - 1
        let itemsCount = viewModel.photo.value.count
        
        if indexPath.row < itemsCount {
            itemSize = CGSize(width: length, height: length)
        } else {
            itemSize = CGSize(width: collectionView.bounds.width, height: 50.0)
        }
        
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }

}


































