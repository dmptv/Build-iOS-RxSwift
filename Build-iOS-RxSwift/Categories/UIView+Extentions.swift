//
//  UIView+Extentions.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 24.08.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit

extension UIView {
    
    func setView(disabled: Bool, decreaseOpacity: Bool = false) {
        isUserInteractionEnabled = !disabled
        
        if disabled {
            alpha = decreaseOpacity ? 0.5 : 1
        } else {
            alpha = 1
        }
    }
    
    

}
