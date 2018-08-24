//
//  LoginFlow.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 23.08.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit
import Material

class LoginFlow: Flow {
    
    var root: Presentable {
        return self.rootViewController
    }
    
    private var rootViewController: UINavigationController
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func navigate(to step: Step) -> NextFlowItems {
        guard let step = step as? AppStep else { return NextFlowItems.stepNotHandled }
        
        switch step {
        case .login:
            return navigateToLoginScreen()
        case .unauthorized:
            return navigateToLoginScreen(isUnauthorized: true)
        default:
            return NextFlowItems.none
        }
    }
    
    private func navigateToLoginScreen(isUnauthorized: Bool = false) -> NextFlowItems {
        let viewController = LoginViewController.instantiate(withViewModel: LoginViewModel())
        viewController.isUnauthorized = isUnauthorized
        self.rootViewController.pushViewController(viewController, animated: true)
        return NextFlowItems.one(
            flowItem: NextFlowItem(
                nextPresentable: viewController,
                nextStepper: viewController)
        )
    }
   
    

}
















