//
//  PhotoLoadingCell.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 07.09.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SnapKit

class PhotoLoadingCell: UICollectionReusableView, ReuseIdentifierProtocol {
    
    private var spinner = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 44, height: 44), type: .ballPulse, color: App.Color.azure, padding: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(spinner)
        spinner.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    public func startLoading() {
        spinner.isHidden = false
        spinner.startAnimating()
    }
    
    public func stopLoading() {
        spinner.isHidden = true
        spinner.stopAnimating()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
