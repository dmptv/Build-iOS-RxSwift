//
//  User.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 23.08.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxCocoa

struct User: Codable {
    
    var name: String
    var lastName: String
    var password: String
    
    var isAuthenticated: Bool {
        return false
    }
    
     // MARK: - Methods
    
    private static var _current: User?
    static var current: User {
        get {
            if _current != nil {
                return _current!
            }
            _current = User(name: "name", lastName: "lastname", password: "password")
            
            return _current!
        }
        set(newValue) {
            _current = newValue
        }
    }
    
    
    
    
    
    
    
}









