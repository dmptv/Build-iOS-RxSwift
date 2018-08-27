//
//  Error+Extentions.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 27.08.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import Foundation
import Moya

extension Error {
    
    func parseMessages() -> [String: String] {
        var errorMessages = [String: String]()
        
        if let moyaError = self as? MoyaError {
            switch moyaError {
            case .statusCode(let response):
                let responseError = response.parseError()
                errorMessages = responseError.message
            default:
                break
            }
        }
        
        return errorMessages
    }
    
}
