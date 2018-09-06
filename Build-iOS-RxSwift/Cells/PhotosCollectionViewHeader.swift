//
//  PhotosCollectionViewHeader.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 06.09.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit

class PhotosCollectionViewHeader: UICollectionReusableView, ReuseIdentifierProtocol {
    var titleLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        titleLabel.backgroundColor = App.Color.grayBackground
        titleLabel.textAlignment = .center
        titleLabel.textColor = App.Color.darkSlateBlue
        titleLabel.font = App.Font.bodyAlts
        
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}











