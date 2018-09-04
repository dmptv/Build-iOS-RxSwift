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
    var password: String
    
    var isAuthenticated: Bool {
        get {
//            return false
            return User._current != nil
        }
    }
    
    let updated = BehaviorRelay<String?>(value: nil)

    init(name: String, password: String) {
        self.name = name
        self.password = password
    }
    
    
    // MARK: - Codable
    
    enum CodingKeys: String, CodingKey {
        case name
        case password
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: CodingKeys.name)
        self.password = try container.decode(String.self, forKey: CodingKeys.password)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: CodingKeys.name.rawValue)
        aCoder.encode(password, forKey: CodingKeys.password.rawValue)
    }
    
     // MARK: - Methods
    
    private static var _current: User?
    static var current: User {
        get {
            if _current != nil {
                return _current!
            }
            
            let name = UserDefaults.standard.string(forKey: App.Key.name) ?? ""
            let password = UserDefaults.standard.string(forKey: App.Key.password) ?? ""
                        
            _current = User(name: name, password: password)
            _current?.updated.accept(name)
            
            return _current!
        }
        set(newValue) {
            _current = newValue
        }
    }
    
    public func save() {
        UserDefaults.standard.set(name, forKey: App.Key.name)
        UserDefaults.standard.set(password, forKey: App.Key.password)
        UserDefaults.standard.synchronize()
        
        updated.accept(User._current?.name)
    }
    
    public func logout() {
        User._current = nil
     
        UserDefaults.standard.set(nil, forKey: App.Key.name)
        UserDefaults.standard.set(nil, forKey: App.Key.password)
        UserDefaults.standard.synchronize()
        
        removeUserRelatedData()
    }
    
    private func removeUserRelatedData() {
        DispatchQueue.global().async {
           
        }
    }
    
    
    
    
}









