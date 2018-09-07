//
//  FlickrPhotosView.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 07.09.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit
import Material
import SnapKit
import RxSwift
import RxCocoa

class FlickrPhotosView: UIView {

    private(set) var collectionView: UICollectionView!
    public var itemsCount = BehaviorRelay<Int>(value: 0)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    // MARK: - UI
    private func setupUI() {
        setupCollectionView()
    }
    
    fileprivate func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionHeadersPinToVisibleBounds = true
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        
        collectionView.register(PhotosColectionViewCell.self, forCellWithReuseIdentifier: PhotosColectionViewCell.defaultReuseIdentifier)
        collectionView.register(PhotosCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: PhotosCollectionViewHeader.defaultReuseIdentifier)
    }

}

// MARK:- CollectionView Delegate FlowLayout
extension FlickrPhotosView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var itemSize: CGSize
        let length = (UIScreen.main.bounds.width) / 3 - 1
        
        if indexPath.row < itemsCount.value {
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: 30.0)
    }
    
    
}




















































