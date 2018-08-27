//
//  Bundle+Extentions.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 27.08.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit

extension Bundle {
    
    public func stubJSONWith(name: String) -> Data {
        guard let jsonPath = path(forResource: name, ofType: "json"),
            let url = URL(string: jsonPath),
            let data = try? Data(contentsOf: url) else {
                return "{}".utf8Encoded
        }
        return data
    }
    
}

internal func printMine(items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
    var i = items.startIndex
    repeat {
        Swift.print(items[i], separator: separator, terminator: i == (items.endIndex - 1) ? terminator : separator)
        i += 1
    } while i < items.endIndex
    #endif
}

