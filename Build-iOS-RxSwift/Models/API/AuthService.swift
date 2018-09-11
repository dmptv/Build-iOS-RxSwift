//
//  AuthService.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 27.08.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import Foundation
import Moya

enum AuthService {
    case user(login: String, password: String)
}

extension AuthService: AuthorizedTargetType {
    
    var path: String {
        switch self {
        case .user:
            return "/user"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .user:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .user(login, password):
            return .requestParameters(parameters: ["login": login, "password": password],
                                      encoding: JSONEncoding.default)
        }
    }
    
    var sampleData: Data {
        switch self {
        case .user:
            return Bundle.main.stubJSONWith(name: "user")
        }
    }
    
    var headers: [String: String]? {
        return nil 
    }
    
    var needsAuth: Bool {
        switch self {
        case .user:
            return false
        }
    }
    
}

protocol AuthorizedTargetType: TargetType {
    var needsAuth: Bool { get }

}

extension AuthorizedTargetType {
    var baseURL: URL { return URL(string: App.StringStruct.githubBaseUrl)! }
}


































