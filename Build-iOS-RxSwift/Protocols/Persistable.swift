//
//  Persistable.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 04.09.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import Foundation
import RealmSwift

public protocol Persistable {
    associatedtype ManagedObject: RealmSwift.Object
    
    init(managedObject: ManagedObject)
    
    func managedObject() -> ManagedObject
}
