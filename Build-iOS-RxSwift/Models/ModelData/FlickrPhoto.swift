//
//  FlickrPhotoModel.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 04.09.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import Foundation
import RxDataSources

struct FlickrPhoto: Decodable, Equatable {
    
    let id: String
    let farm: Int
    let secret: String
    let server: String
    let title: String
    
    // Equatable
    static func == (lhs: FlickrPhoto, rhs: FlickrPhoto) -> Bool {
        return lhs.id == rhs.id
    }
    
    // MARK: - Decodable

    enum CodingKeys: String, CodingKey {
        case id
        case farm
        case secret
        case server
        case title
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeWrapper(key: .id, defaultValue: "0")
        self.farm = try container.decodeWrapper(key: .farm, defaultValue: -1)
        self.secret = try container.decodeWrapper(key: .secret, defaultValue: "")
        self.server = try container.decodeWrapper(key: .server, defaultValue: "")
        self.title = try container.decodeWrapper(key: .title, defaultValue: "")
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(farm, forKey: "farm")
        aCoder.encode(secret, forKey: "secret")
        aCoder.encode(server, forKey: "server")
        aCoder.encode(title, forKey: "title" )
    }
    
    var photoUrl: URL {
        return flickrImageURL()
    }

    var largePhotoUrl: URL {
        return flickrImageURL(size: "b")
    }

    private func flickrImageURL(size: String = "m") -> URL {
        return URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_\(size).jpg")!
    }
}

//FIXME: - make realm logic

// MARK: - Persistable

//extension FlickrPhoto: Persistable {
//    func managedObject() -> FlickrPhotoObject {
//        let object = FlickrPhotoObject()
//        object.id = id
//        object.farm = farm
//        object.secret = secret
//        object.server = server
//        object.title = title
//        return object
//    }
//
//    public init(managedObject: FlickrPhotoObject) {
//        id = managedObject.id
//        farm = managedObject.farm
//        secret = managedObject.secret
//        server = managedObject.server
//        title = managedObject.title
//    }
//}

extension FlickrPhoto: IdentifiableType {
    var identity: Identity {
        return self.id
    }
    typealias Identity = String
}

































