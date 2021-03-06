//
//  AppStep.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 22.08.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import Foundation

enum AppStep: Step {
    
     // MARK: - Login
    
    case login
    case forgotPassword(login: String)
    case forgotPasswordCansel
    case resetPassword
    case unauthorized
    
    // MARK: - Main tab bar
    case mainMenu
    
    case firstVC
    case secondVC
    case thirdVC
    case fourthVC
    case firstBoard

    
    // MARK: - Notifications
    
    case notifications
    case notificationsDone
    
    // MARK: - Global Search 
    case newsSearch
    case suggestionSearch
    case questionSearch
    
}
