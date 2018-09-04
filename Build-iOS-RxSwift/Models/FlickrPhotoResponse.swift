//
//  FlickrPhotoResponse.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 05.09.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import Foundation

struct Root: Decodable {
    let photos: FlickrPhotoResponse
    let stat: String
    
    enum CodingKeys: String, CodingKey {
        case photos
        case stat
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.stat = try container.decodeWrapper(key: .stat, defaultValue: "")
        self.photos = try container.decode(FlickrPhotoResponse.self, forKey: .photos)
    }
}

struct FlickrPhotoResponse: Decodable {
    let pages: Int
    let total: String
    let perpage: Int
    let page: Int
    let photo: [FlickrPhoto]
    
    // MARK: - Decodable
    
    enum CodingKeys: String, CodingKey {
        case total
        case perpage
        case page
        case pages
        case photo
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.pages = try container.decodeWrapper(key: .pages, defaultValue: 0)
        self.total = try container.decodeWrapper(key: .total, defaultValue: "")
        self.perpage = try container.decodeWrapper(key: .perpage, defaultValue: 0)
        self.page = try container.decodeWrapper(key: .page, defaultValue: 0)
        self.photo = try container.decode([FlickrPhoto].self, forKey: .photo)
    }
    
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(total, forKey: "total")
//        aCoder.encode(perpage, forKey: "perpage")
//        aCoder.encode(page, forKey: "page")
//        aCoder.encode(pages, forKey: "pages")
//    }
    
}

// MARK: - Persistable

//extension FlickrPhotoResponse: Persistable {
//    init(managedObject: FlickrPhotoResponseObject) {
//        total = managedObject.total
//        perpage = managedObject.perpage
//        page = managedObject.page
//        pages = managedObject.pages
//    }
//
//    func managedObject() -> FlickrPhotoResponseObject {
//        let object = FlickrPhotoResponseObject()
//        object.total = total
//        object.perpage = perpage
//        object.page = page
//        object.pages = pages
//        return object
//    }
//}























