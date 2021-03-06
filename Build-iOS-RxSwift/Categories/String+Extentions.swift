//
//  String+Extentions.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 27.08.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import Foundation
import DateToolsSwift
import Moya

public extension String {

    // make data from custom json
    public var utf8Encoded: Data {
        return data(using: .utf8)!
    }
    
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
}
































