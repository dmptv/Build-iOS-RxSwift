//
//  FirstVCFlow.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 29.08.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit

class FirstVCFlow: Flow {
    
    var root: Presentable {
        return self.rootViewController
    }
    
    private let rootViewController: FirstViewController
    
    init(viewController: FirstViewController) {
        rootViewController = viewController
    }
    
    func navigate(to step: Step) -> NextFlowItems {
        guard let step = step as? AppStep else { return NextFlowItems.stepNotHandled }
        
        switch step {
        case .firstVC:
            return NextFlowItems.one(flowItem: NextFlowItem(nextPresentable: rootViewController,
                                                            nextStepper: rootViewController))
        default:
            return NextFlowItems.stepNotHandled
        }
    }
    
}






































