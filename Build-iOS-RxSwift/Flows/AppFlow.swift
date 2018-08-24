//
//  AppFlow.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 22.08.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit

class AppFlow: Flow {
    
    var root: Presentable {
        return rootWindow
    }
    
    private let rootWindow: UIWindow
    
    init(with window: UIWindow) {
        self.rootWindow = window
    }
    
    func navigate(to step: Step) -> NextFlowItems {
        guard let step = step as? AppStep else  {
            return NextFlowItems.stepNotHandled
        }
        
        switch step {
        case .login:
            return navigationToLoginScreen()
        case .unauthorized:
            return navigationToLoginScreen(isUnathorized: true)
        case .mainMenu:
            return navigationToMainMenuScreen()
        default:
            return NextFlowItems.stepNotHandled
        }
    }
    
    private func navigationToLoginScreen (isUnathorized: Bool = false) -> NextFlowItems {
        let navVC = UINavigationController()
        navVC.setNavigationBarHidden(true, animated: false)
        let loginFlow = LoginFlow(rootViewController: navVC)
        
        Flows.whenReady(flow1: loginFlow) { (navigationController: UINavigationController) in
            self.rootWindow.rootViewController = navigationController
        }
        
        let step = isUnathorized ? AppStep.unauthorized : AppStep.login
        let flowItem = NextFlowItem(nextPresentable: loginFlow,
                                    nextStepper: OneStepper(withSingleStep: step))
        
        return NextFlowItems.one(flowItem: flowItem)
    }
    
    private func navigationToMainMenuScreen () -> NextFlowItems {
        
        return NextFlowItems.none
    }
}





















