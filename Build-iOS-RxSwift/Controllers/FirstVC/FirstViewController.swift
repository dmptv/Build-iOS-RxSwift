//
//  FirstViewController.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 29.08.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import IGListKit
import Material
import Moya
import PopupDialog
import RxSwift
import SnapKit

class FirstViewController: UIViewController, Stepper, FABMenuDelegate {
    
    private(set) var viewModel: FirstVCViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: FirstVCViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
}



















