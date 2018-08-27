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
    @objc dynamic var authorCode: String = ""
    @objc dynamic var authorName: String = ""
    @objc dynamic var isAllDay: Bool = false
    @objc dynamic var startDate: String?
    @objc dynamic var endDate: String?
    @objc dynamic var location: String?
    @objc dynamic var isExpired: Bool = false
    @objc dynamic var descriptionText: String = ""
    @objc dynamic var executorCode: String = ""
    @objc dynamic var executorName: String = ""
    @objc dynamic var reminder: Int = 0
    @objc dynamic var approveEntityId: String = ""
    @objc dynamic var approveEntityType: String = ""
    @objc dynamic var label: String = ""
    let attachments = List<String>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}








