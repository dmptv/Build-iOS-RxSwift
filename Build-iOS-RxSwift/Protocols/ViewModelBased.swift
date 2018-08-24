//
//  ViewModelBased.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 23.08.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit

protocol ViewModel {}

protocol ServicesViewModel: ViewModel {
    associatedtype Services
    var services: Services! { get set }
}

protocol ViewModelBased: class {
    associatedtype ViewModelType: ViewModel
    var viewModel: ViewModelType! { get set }
}

extension ViewModelBased where Self: UIViewController {
    static func instantiate<ViewModelType>(withViewModel viewModel: ViewModelType) -> Self where ViewModelType == Self.ViewModelType {
        
        let viewController = Self.init()
        viewController.viewModel = viewModel
        
        return viewController
    }
}

extension ViewModelBased where Self: UIViewController, ViewModelType: ServicesViewModel {
    
    static func instantiate<ViewModelType, ServicesType>(withViewModel viewModel: ViewModelType,
                                                         andServices services: ServicesType) -> Self
        where ViewModelType == Self.ViewModelType, ServicesType == Self.ViewModelType.Services {
        
            let viewController = Self.init()
            viewController.viewModel = viewModel
            viewController.viewModel.services = services
        
            return viewController
    }
}





















