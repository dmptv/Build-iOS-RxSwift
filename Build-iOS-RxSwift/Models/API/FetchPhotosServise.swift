//
//  FetchPhotosServise.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 31.08.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import Foundation
import Moya

enum FetchPhotosServise {
    case photos(searchText: String, page: Int)
}

extension FetchPhotosServise: AuthorizedTargetType {
    
    var baseURL: URL { return URL(string: App.StringStruct.flickrBaseURL)! }

    var path: String {
        switch self {
        case .photos:
            return "/services/rest"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .photos:
            return .get
        }
    }
    
    
    ///  https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=2d2e1b0d53275fd4ae2158e0c0937472&tags=Party&page=1&format=json&nojsoncallback=1
    
    /// https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&page=%i&format=json&nojsoncallback=1"

    
    var task: Moya.Task {
        switch self {
        case let .photos(searchText, page):
            let parameters = [
                "method": "flickr.photos.search",
                "api_key": App.StringStruct.APIKey,
                "tags": searchText.URLEscapedString,
                "page": page,
                "format": "json",
                "nojsoncallback": 1
                ] as [String : Any]
            return .requestParameters(parameters: parameters,
                                      encoding: URLEncoding.default)
        }
    }
    
    var sampleData: Data {
        switch self {
        case .photos:
            return Bundle.main.stubJSONWith(name: "photos")
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var needsAuth: Bool {
        switch self {
        case .photos:
            return false
        }
    }
 
}







