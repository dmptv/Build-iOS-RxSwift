//
//  NotificationsViewController.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 29.08.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import Material
import Moya
import RxSwift
import RxCocoa
import SnapKit

class NotificationsViewController: UIViewController, ViewModelBased, Stepper {
    typealias ViewModelType = NotificationsViewModel
    
    var viewModel: NotificationsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .cyan 
    }
    
}
