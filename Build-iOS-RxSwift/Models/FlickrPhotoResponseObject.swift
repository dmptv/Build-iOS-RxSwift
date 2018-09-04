//
//  FlickrPhotoResponseObject.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 05.09.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import Foundation
import RealmSwift

class FlickrPhotoResponseObject: Object {
    @objc dynamic var total: String = ""
    @objc dynamic var perpage: Int = 0
    @objc dynamic var page: Int = 0
    @objc dynamic var pages: Int = 0
    

    override static func primaryKey() -> String? {
        return "page"
    }
}
