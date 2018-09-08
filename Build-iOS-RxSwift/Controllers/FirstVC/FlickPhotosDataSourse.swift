//
//  FlickPhotosDataSourse.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 07.09.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class FlickPhotosDataSourse {
    
    var dataSource: RxCollectionViewSectionedAnimatedDataSource<SectionOfCustomData>?
    
    var collectionView: UICollectionView!
//    private var currentPage = 1
    var pages = BehaviorRelay<Int>(value: 1)
    var currentPage = BehaviorRelay<Int>(value: 1)
    
    var isFetchPhotos = BehaviorRelay<Bool>(value: false)
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        
        dataSource = RxCollectionViewSectionedAnimatedDataSource<SectionOfCustomData>(configureCell: {
            _, cv, indexPath, item in
            
            return self.photoItemCell(cv, cellForItemAt: indexPath, item: item)
            
        }, configureSupplementaryView: { [weak self] item, cv, kind, indexPath in
            guard let `self` = self else { return UICollectionReusableView() }
            
            return self.setupHeaderFooter(kind: kind, indexPath: indexPath, cv: cv)
            
            },
           moveItem: { _, _, _  in },
           canMoveItemAtIndexPath: { _, _ in true })
    }
    
    fileprivate func setupHeaderFooter(kind: String, indexPath: IndexPath, cv: UICollectionView) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let header = cv.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PhotosCollectionViewHeader.defaultReuseIdentifier, for: indexPath) as! PhotosCollectionViewHeader
            header.titleLabel.text = "New York"
            return header
        }
        let footer = cv.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PhotoLoadingCell.defaultReuseIdentifier, for: indexPath) as! PhotoLoadingCell
        footer.backgroundColor = .clear

        if self.currentPage.value < self.pages.value {
            footer.startLoading()
        } else {
            footer.stopLoading()
        }
        
        self.isFetchPhotos.accept(true)
        self.currentPage.accept(self.currentPage.value)
        
        return footer
    }
    
    fileprivate func photoItemCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, item: SectionOfCustomData.Item) -> UICollectionViewCell {
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
  
}




















