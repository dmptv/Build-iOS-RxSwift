//
//  PhotosColectionViewCell.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 06.09.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit

class PhotosColectionViewCell: UICollectionViewCell, ReuseIdentifierProtocol {
    
    var photoImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.layer.masksToBounds = true
        return img
    }()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(photoImageView)
        
        photoImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}















