//
//  MainMenuFlow.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 28.08.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit
import Material
import Moya

class MainMenuFlow: Flow {
    
    private lazy var notificationsViewModel = NotificationsViewModel()
    
    var root: Presentable {
        return self.rootViewController
    }
    
    private let rootViewController: AppNavbarController
    private let tabBarViewController: AppTabBarController
    
    init() {
        tabBarViewController = AppTabBarController()
        
        rootViewController = AppNavbarController(rootViewController: tabBarViewController)
        rootViewController.setupToolbarButtons(for: tabBarViewController)
        rootViewController.didTapNotifications = { [weak self] in
            self?.tabBarViewController.step.accept(AppStep.notifications)
        }

        rootViewController.didTapSearch = { [weak self] in
            self?.tabBarViewController.step.accept(AppStep.newsSearch)
        }
    }
    
    func navigate(to step: Step) -> NextFlowItems {
        guard let step = step as? AppStep else { return NextFlowItems.stepNotHandled }
        
        switch step {
        case .mainMenu:
            return navigationToMainMenuScreen()
        case .notifications:
            return navigationToNotifications()
        default:
            return NextFlowItems.stepNotHandled
        }
        
    }
    
    // MARK: - Navigation
    
    private func navigationToMainMenuScreen() -> NextFlowItems {
        let tabBarFlowItem = NextFlowItem(nextPresentable: rootViewController,
                                          nextStepper: tabBarViewController)
        
        let firstViewController = configuredFirstVC()
        let firstVCFlow = FirstVCFlow(viewController: firstViewController)
        let stepper = OneStepper(withSingleStep: AppStep.firstVC)
        let firstVCFlowItem = NextFlowItem(nextPresentable: firstVCFlow,
                                           nextStepper: stepper)
        
        tabBarViewController.viewControllers = [firstViewController]
        
        let flowItems: [NextFlowItem] = [tabBarFlowItem, firstVCFlowItem]
        return NextFlowItems.multiple(flowItems: flowItems)
    }
    
    private func navigationToNotifications() -> NextFlowItems {
        let notificationsViewController = NotificationsViewController.instantiate(withViewModel: notificationsViewModel)
        rootViewController.present(notificationsViewController, animated: true, completion: nil)
        
        let nextFlowItem = NextFlowItem(nextPresentable: notificationsViewController,
                                        nextStepper: notificationsViewController)
        return NextFlowItems.one(flowItem: nextFlowItem)
    }
  
    // MARK: - Methods
    
    private func configuredFirstVC() -> FirstViewController {
        let viewModel = FirstVCViewModel()
        let services = MoyaProvider<FetchPhotosServise>(plugins: [
            NetworkLoggerPlugin(verbose: true),
            AuthPlugin(tokenClosure: { return App.StringStruct.APIKey }),
            NetworkActivityPlugin(networkActivityClosure: { (type, targetType) in
                switch type {
                case .began:
                    print("--> NetworkActivity began")
                case .ended:
                    print("--> NetworkActivity ended")
                }
            })
            ])
        let viewController = FirstViewController.instantiate(withViewModel: viewModel, andServices: services)
        return viewController
    }

}



















