//
//  TaskObject.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 27.08.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import Foundation
import RealmSwift

class TaskObject: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var topic: String = ""
    @objc dynamic var label: String = ""
    let attachments = List<String>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}








