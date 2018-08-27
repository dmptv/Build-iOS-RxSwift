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
    
    var updated: BehaviorRelay<User?> {
        return BehaviorRelay<User?>(value: nil)
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
    
    public func save() {
        UserDefaults.standard.set(name, forKey: App.Key.name)
        UserDefaults.standard.set(lastName, forKey: App.Key.lastName)
        UserDefaults.standard.set(password, forKey: App.Key.password)
        UserDefaults.standard.synchronize()
        
        updated.accept(User._current)
    }
    
    public func logout() {
        User._current = nil
     
        UserDefaults.standard.set(nil, forKey: App.Key.name)
        UserDefaults.standard.set(nil, forKey: App.Key.lastName)
        UserDefaults.standard.set(nil, forKey: App.Key.password)
        UserDefaults.standard.synchronize()
        
        removeUserRelatedData()
    }
    
    private func removeUserRelatedData() {
        DispatchQueue.global().async {
            do {
                // tasks and requests
                var tasksAndRequestsRealms = [Realm]()
                
                let inboxTasksRealm = try App.Realms.inboxTasksAndRequests()
                tasksAndRequestsRealms.append(inboxTasksRealm)
                
                let outboxTasksRealm = try App.Realms.outboxTasksAndRequests()
                tasksAndRequestsRealms.append(outboxTasksRealm)
                
                for realm in tasksAndRequestsRealms {
                    realm.beginWrite()
                    realm.delete(realm.objects(TaskObject.self))
                    try realm.commitWrite()
                }
                
                // notifications
                let notifictationsRealm = try App.Realms.notifications()
                notifictationsRealm.beginWrite()
                notifictationsRealm.delete(notifictationsRealm.objects(NotificationObject.self))
                try notifictationsRealm.commitWrite()
            } catch {
                print("Failed to access the Realm database")
            }
        }
    }
    
    
    
    
}









