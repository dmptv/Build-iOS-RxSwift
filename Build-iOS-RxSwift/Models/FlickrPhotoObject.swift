//
//  TaskObject.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 27.08.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import Foundation
import RealmSwift

class FlickrPhotoObject: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var farm: Int = -1
    @objc dynamic var secret: String = ""
    @objc dynamic var server: String = ""
    @objc dynamic var title: String = ""

    override static func primaryKey() -> String? {
        return "photoId"
    }
}
























