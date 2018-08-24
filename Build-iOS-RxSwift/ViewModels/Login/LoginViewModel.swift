//
//  LoginViewModel.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 23.08.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxCocoa

struct LoginViewModel: ViewModel {
    
    private var disposeBag = DisposeBag()
    
    var loginErrorMessage = BehaviorRelay<String?>(value: nil)
    var passwordErrorMessage = BehaviorRelay<String?>(value: nil)
    
    // MARK: - Methods
    
    public func login(_ login: String, password: String,
                      completion: @escaping /*One and only sequence element is produced*/ ((SingleEvent<Response>) -> Void)) {
        
        
    }
        
    
    
}


























