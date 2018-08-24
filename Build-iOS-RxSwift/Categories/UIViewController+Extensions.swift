//
//  UIViewController+Extensions.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 23.08.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit
import Kingfisher
import Material
import MBProgressHUD
import NVActivityIndicatorView
import RxSwift
import RxCocoa
import Toast

enum ToastPosition {
    case bottom, center, top
}

extension UIViewController {
    
    // MARK: - Toast
    
    func showToast(_ message: String, position: ToastPosition = .bottom) {
        var toastPosition = CSToastPositionBottom
        if position == .center {
            toastPosition = CSToastPositionCenter
        } else if position == .top {
            toastPosition = CSToastPositionTop
        }
        
        view.makeToast(message, duration: 2.0, position: toastPosition)
    }
}






























