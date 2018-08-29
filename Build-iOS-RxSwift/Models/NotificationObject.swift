//
//  NotificationObject.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 27.08.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import Foundation
import RealmSwift

class NotificationObject: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var message: String = ""
    @objc dynamic var authorCode: String = ""
    @objc dynamic var authorName: String = ""
    @objc dynamic var createDate: String = ""
    @objc dynamic var entityId: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
