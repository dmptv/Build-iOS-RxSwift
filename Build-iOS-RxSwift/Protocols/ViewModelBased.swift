//
//  ViewModelBased.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 23.08.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit

protocol ViewModel {}

// view model should conform to
protocol ServicesViewModel: ViewModel {
    associatedtype Services
    var services: Services! { get set }
}

// view controller should conform to
protocol ViewModelBased {
    associatedtype ViewModelType: ViewModel
    var viewModel: ViewModelType! { get set }
}

// we can instantiate view controller with dependency
extension ViewModelBased where Self: UIViewController {
    static func instantiate<ViewModelType>(withViewModel viewModel: ViewModelType) -> Self where ViewModelType == Self.ViewModelType {
        
        var viewController = Self.init()
        viewController.viewModel = viewModel
        
        return viewController
    }
}

extension ViewModelBased where Self: UIViewController, ViewModelType: ServicesViewModel {
    static func instantiate<ViewModelType, ServicesType>(withViewModel viewModel: ViewModelType,
                                                         andServices services: ServicesType) -> Self
        where ViewModelType == Self.ViewModelType, ServicesType == Self.ViewModelType.Services {
        
            var viewController = Self.init()
            viewController.viewModel = viewModel
            viewController.viewModel.services = services
        
            return viewController
    }
}





















